/*
 * Copyright (c) 1998-1999 Sigma6 Inc.  All rights reserved.
 *
 * $Id: SessionManager.java,v 1.1 2000/06/20 15:44:12 lswanson Exp $
 */

package COM.worlddealer.cfx;

import COM.sigma6.cfx.CFXException;
import COM.sigma6.cfx.CFXHandler;
import COM.sigma6.cfx.CFXQuery;
import COM.sigma6.cfx.CFXRequest;
import COM.sigma6.cfx.CFXSession;

import java.util.Enumeration;

public class SessionManager extends CFXHandler {
	public void handle(CFXRequest request) throws CFXException {
		try {
			if (request.attributeExists("ACTION")) {
				String action = request.getAttribute("ACTION");

				if (action.equalsIgnoreCase("create")) {
					/*
					 * Create a new session.
					 *    return - required; receives new session id
					 */
					String result = getResult(request);
					CFXSession session = new CFXSession();

					request.setVariable(result, session);
				} else if (action.equalsIgnoreCase("verify")) {
					/*
					 * Verify a session id.
					 *    sessionID - required
					 *    return - required; receives "true" or "false"
					 */
					String result = getResult(request);
					CFXSession session = getSession(request);

					if (session != null) session.refresh();
					request.setVariable(result,
						session != null ? "true" : "false");
				} else if (action.equalsIgnoreCase("getProperty")) {
					/*
					 * Retrieves a property of a session.
					 *    sessionID - required
					 *    name - required; name of property
					 *    return - required; receives property value
					 */
					String result = getResult(request);
					String name = getName(request);
					CFXSession session = getSession(request);

					if (session == null)
						throw new CFXException("Invalid session: " +
							request.getAttribute("sessionID"));
					request.setVariable(result, session.getProperty(name));
				} else if (action.equalsIgnoreCase("hasProperty")) {
					/*
					 * Indicates whether the specified property is set.
					 *    sessionID - required
					 *    name - required; name of property
					 *    return - required; receives true or false
					 */
					String result = getResult(request);
					String name = getName(request);
					CFXSession session = getSession(request);

					if (session == null)
						throw new CFXException("Invalid session: " +
							request.getAttribute("sessionID"));
					Object value = session.getProperty(name);
					request.setVariable(result,
						value != null ? "true" : "false");
				} else if (action.equalsIgnoreCase("setProperty")) {
					/*
					 * Sets a property of a session.
					 *    sessionID - required
					 *    name - required; name of property
					 *    value - required; value of property
					 */
					String name = getName(request);
					String value = getValue(request);
					CFXSession session = getSession(request);

					if (session == null)
						throw new CFXException("Invalid session: " +
							request.getAttribute("sessionID"));
					session.setProperty(name, value);
				} else if (action.equalsIgnoreCase("removeProperty")) {
					/*
					 * Removes a property from a session.
					 *    sessionID - required
					 *    name - required; name of property
					 */
					String name = getName(request);
					CFXSession session = getSession(request);

					if (session == null)
						throw new CFXException("Invalid session: " +
							request.getAttribute("sessionID"));
					session.removeProperty(name);
				} else if (action.equalsIgnoreCase("listProperties")) {
					/*
					 * Lists properties of a session.
					 *    sessionID - required
					 *    return - required; receives list of session
					 *             properties
					 */
					CFXSession session = getSession(request);

					if (session != null) {
						String result = getResult(request);
						String[] columns = {"name", "value"};
						CFXQuery query = request.addQuery(result, columns);
						Enumeration props = session.getProperties();

						while (props.hasMoreElements()) {
							String name = (String)props.nextElement();
							int r = query.addRow();

							query.setData(r, 1, name);
							query.setData(r, 2, session.getProperty(name));
						}
					} else {
						throw new CFXException("Invalid session: " +
							request.getAttribute("sessionID"));
					}
				} else if (action.equalsIgnoreCase("listSessions")) {
					/*
					 * List all current sessions.
					 *    return - required; receives list of session
					 *             attributes
					 */
					String result = getResult(request);
					String[] columns = {"sid", "timeout", "username"};
					CFXQuery query = request.addQuery(result, columns);
					Enumeration e = CFXSession.getAllSessions();

					while (e.hasMoreElements()) {
						CFXSession session = (CFXSession)e.nextElement();
						int r = query.addRow();

						query.setData(r, 1, session);
						query.setData(r, 2, session.getTimeout());
					}
				} else {
					throw new CFXException(
						"Invalid value for ACTION: " + action);
				}
			} else {
				throw new CFXException("Required parameter ACTION missing");
			}
		} catch (Exception ex) {
			// something went horribly wrong...
			ex.printStackTrace();
			throw new CFXException(
				ex.getClass().getName() + ": " + ex.getMessage());
		}
	}

	private String getResult(CFXRequest request) throws CFXException {
		if (request.attributeExists("return"))
			return request.getAttribute("return");
		throw new CFXException("Required parameter RETURN missing");
	}

	private String getName(CFXRequest request) throws CFXException {
		if (request.attributeExists("name"))
			return request.getAttribute("name");
		throw new CFXException("Required parameter NAME missing");
	}

	private String getValue(CFXRequest request) throws CFXException {
		if (request.attributeExists("value"))
			return request.getAttribute("value");
		throw new CFXException("Required parameter VALUE missing");
	}

	static CFXSession getSession(CFXRequest request) throws CFXException {
		if (request.attributeExists("sessionID")) {
			try {
				return CFXSession.getSession(
					Long.parseLong(request.getAttribute("sessionID"), 16));
			} catch (NumberFormatException ex) {
				// do nothing
			}
		}
		return null;
	}
}
