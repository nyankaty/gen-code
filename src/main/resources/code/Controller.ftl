package ${controllerPackage};

import common.ResponseCodeFactory;
import ${layerClassPath};
import delegate.nemoapp.LoginLayer;
import ${modelPackage}.Get${modelClassName};
import model.nemoapp.login.AccessTokenForm;

import log.Configurator;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import util.DataFormat;

/**
* ${title}
*
* @author ${author}
* @version ${version}
*/
public class ${controllerClassName} extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static Logger log = Logger.getLogger("${controllerClassName}.class");

    private Configurator _configurator;

    /**
    * @see HttpServlet#HttpServlet()
    */
    public ${controllerClassName}() {
        super();
    }

    /**
    * @see HttpServlet #doGet(HttpServletRequest request, HttpServletResponse response)
    */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        refuseRequest(request, response, "GET");
    }

    /**
    * @see HttpServlet #doPost(HttpServletRequest request, HttpServletResponse response)
    */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
    * @see HttpServlet #doOptions(HttpServletRequest request, HttpServletResponse response)
    */
    protected void doOptions(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        refuseRequest(request, response, "OPTIONS");
    }

    /**
    * Refuse requests for both HTTP <code>GET</code> and <code>OPTIONS</code> methods.
    *
    * @param request Servlet Request
    * @param response Servlet Response
    *
    * @throws ServletException if a servlet-specific error occurs
    * @throws IOException if an I/O error occurs
    */
    protected void refuseRequest(HttpServletRequest request, HttpServletResponse response, String requestMethod) throws ServletException, IOException {

        PrintWriter out = null;

        try {
            // Configure properties for log files
            _configurator = new Configurator();
            _configurator.configureProperties();

            // Set request character encoding
            request.setCharacterEncoding("UTF-8");

            // Add response header
            response.addHeader("Access-Control-Allow-Origin", "*");
            response.addHeader("Access-Control-Allow-Methods", "GET,POST,OPTIONS");
            response.addHeader("Access-Control-Allow-Credentials", "true");
            response.addHeader("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
            response.addHeader("Access-Control-Max-Age", "3600");

            // Set the content type
            response.setContentType("application/json;charset=UTF-8");

            // Set the status
            response.setStatus(HttpServletResponse.SC_OK);

            // Get the writer
            out = response.getWriter();

            log.info("Request is denied for " + requestMethod);
            out.print("{" +
                        "\"error\":" + ResponseCodeFactory.REQUEST_DENIED_CODE + "," +
                        "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.NEMOAPP_MESSAGE_TITLE_ERROR) + "," +
                        "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUEST_DENIED_MESSAGE + requestMethod) +
                      "}");
            return;
        } catch (Exception e) {
            log.error("Request is denied for " + requestMethod);
            out.print("{" +
                        "\"error\":" + ResponseCodeFactory.REQUEST_DENIED_CODE + "," +
                        "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.NEMOAPP_MESSAGE_TITLE_ERROR) + "," +
                        "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUEST_DENIED_MESSAGE + requestMethod) +
                      "}");
            return;
        }
    }

    /**
    * Processes request for HTTP <code>POST</code> method.
    *
    * @param request Servlet Request
    * @param response Servlet Response
    *
    * @throws ServletException if a servlet-specific error occurs
    * @throws IOException if an I/O error occurs
    */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = null;
        Get${modelClassName} result;
        ${layerClassName} layer = new ${layerClassName}();

        try {
            // Configure properties for log files
            _configurator = new Configurator();
            _configurator.configureProperties();

            // Set request character encoding
            request.setCharacterEncoding("UTF-8");

            // Add response header
            response.addHeader("Access-Control-Allow-Origin", "*");
            response.addHeader("Access-Control-Allow-Methods", "GET,POST,OPTIONS");
            response.addHeader("Access-Control-Allow-Credentials", "true");
            response.addHeader("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
            response.addHeader("Access-Control-Max-Age", "3600");

            // Set the content type
            response.setContentType("application/json;charset=UTF-8");

            // Set the status
            response.setStatus(HttpServletResponse.SC_OK);

            // Get the writer
            out = response.getWriter();

            StringBuilder jb = new StringBuilder();
            String line = null;
            JSONObject jsonObject = null;
            BufferedReader reader = null;

            // Get reader
            try {
                reader = request.getReader();
                while ((line = reader.readLine()) != null) {
                    jb.append(line);
                }
                log.info("Request body: " + jb.toString());

                // Parse request string into JSON object
                try {
                    jsonObject = JSONObject.fromObject(jb.toString());
                } catch (Exception e) {
                    log.error("Error parsing request string into JSON object: " + e.getMessage());
                    log.info("Response: " +
                                "{" +
                                    "\"error\":" + ResponseCodeFactory.REQUEST_PARSE_FAILED_CODE + "," +
                                    "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.NEMOAPP_MESSAGE_TITLE_ERROR) + "," +
                                    "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUEST_PARSE_FAILED_MESSAGE + e.getMessage()) +
                                "}");
                    out.print("{" +
                                    "\"error\":" + ResponseCodeFactory.REQUEST_PARSE_FAILED_CODE + "," +
                                    "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.NEMOAPP_MESSAGE_TITLE_ERROR) + "," +
                                    "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUEST_PARSE_FAILED_MESSAGE + e.getMessage()) +
                              "}");

                    return;
                }
            } catch (IOException e) {
                log.error("Error getting Reader: " + e.getMessage());
                log.info("Response: " +
                            "{" +
                                "\"error\":" + ResponseCodeFactory.REQUEST_READ_FAILED_CODE + "," +
                                "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.NEMOAPP_MESSAGE_TITLE_ERROR) + "," +
                                "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUEST_READ_FAILED_MESSAGE + e.getMessage()) +
                            "}");
                out.print("{" +
                                "\"error\":" + ResponseCodeFactory.REQUEST_READ_FAILED_CODE + "," +
                                "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.NEMOAPP_MESSAGE_TITLE_ERROR) + "," +
                                "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUEST_READ_FAILED_MESSAGE + e.getMessage()) +
                          "}");

                return;
            }

            // Get parameters and verify its value
            // app_id
            String app_id;

            try {
                app_id = jsonObject.getString("app_id");

                if (app_id.isEmpty()) {
                    log.info("Response: " +
                                "{" +
                                    "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY + "," +
                                    "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY_CODE)) + "," +
                                    "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY_MESSAGE + "app_id") +
                                "}");
                    out.print("{" +
                                "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY + "," +
                                "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY_CODE)) + "," +
                                "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY_MESSAGE + "app_id") +
                              "}");

                    return;
                }
            } catch (Exception e) {
                log.info("Response: " +
                            "{" +
                                "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_MISSED + "," +
                                "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.REQUIRED_PARAM_MISSED_CODE)) + "," +
                                "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_MISSED_MESSAGE + "app_id") +
                            "}");
                out.print("{" +
                                "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_MISSED + "," +
                                "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.REQUIRED_PARAM_MISSED_CODE)) + "," +
                                "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_MISSED_MESSAGE + "app_id") +
                          "}");

                return;
            }

            // app_version
            String app_version;

            try {
                app_version = jsonObject.getString("app_version");

                if (app_version.isEmpty()) {
                    log.info("Response: " +
                                "{" +
                                    "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY + "," +
                                    "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY_CODE)) + "," +
                                    "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY_MESSAGE + "app_version") +
                                "}");
                    out.print("{" +
                                    "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY + "," +
                                    "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY_CODE)) + "," +
                                    "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY_MESSAGE + "app_version") +
                              "}");

                    return;
                }
            } catch (Exception e) {
                log.info("Response: " +
                            "{" +
                                "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_MISSED + "," +
                                "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.REQUIRED_PARAM_MISSED_CODE)) + "," +
                                "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_MISSED_MESSAGE + "app_version") +
                            "}");
                out.print("{" +
                                "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_MISSED + "," +
                                "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.REQUIRED_PARAM_MISSED_CODE)) + "," +
                                "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_MISSED_MESSAGE + "app_version") +
                          "}");

                return;
            }

            // app_language
            String app_language;

            try {
                app_language = jsonObject.getString("app_language");

                if (app_language.isEmpty()) {
                    log.info("Response: " +
                                "{" +
                                    "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY + "," +
                                    "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY_CODE)) + "," +
                                    "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY_MESSAGE + "app_language") +
                                "}");
                    out.print("{" +
                                    "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY + "," +
                                    "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY_CODE)) + "," +
                                    "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY_MESSAGE + "app_language") +
                              "}");

                    return;
                }
            } catch (Exception e) {
                log.info("Response: " +
                            "{" +
                                "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_MISSED + "," +
                                "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.REQUIRED_PARAM_MISSED_CODE)) + "," +
                                "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_MISSED_MESSAGE + "app_language") +
                            "}");
                out.print("{" +
                                "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_MISSED + "," +
                                "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.REQUIRED_PARAM_MISSED_CODE)) + "," +
                                "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_MISSED_MESSAGE + "app_language") +
                          "}");

                return;
            }

            // device_id
            String device_id;

            try {
                device_id = jsonObject.getString("device_id");
            } catch (Exception e) {
                log.info("Response: " +
                            "{" +
                                "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_MISSED + "," +
                                "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.REQUIRED_PARAM_MISSED_CODE)) + "," +
                                "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_MISSED_MESSAGE + "device_id") +
                            "}");
                out.print("{" +
                                "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_MISSED + "," +
                                "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.REQUIRED_PARAM_MISSED_CODE)) + "," +
                                "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_MISSED_MESSAGE + "device_id") +
                          "}");

                return;
            }

            // device_os
            String device_os;

            try {
                device_os = jsonObject.getString("device_os");
            } catch (Exception e) {
                log.info("Response: " +
                            "{" +
                                "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_MISSED + "," +
                                "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.REQUIRED_PARAM_MISSED_CODE)) + "," +
                                "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_MISSED_MESSAGE + "device_os") +
                            "}");
                out.print("{" +
                                "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_MISSED + "," +
                                "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.REQUIRED_PARAM_MISSED_CODE)) + "," +
                                "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_MISSED_MESSAGE + "device_os") +
                          "}");

                return;
            }

            // device_os_version
            String device_os_version;

            try {
                device_os_version = jsonObject.getString("device_os_version");
            } catch (Exception e) {
                log.info("Response: " +
                            "{" +
                                "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_MISSED + "," +
                                "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.REQUIRED_PARAM_MISSED_CODE)) + "," +
                                "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_MISSED_MESSAGE + "device_os_version") +
                            "}");
                out.print("{" +
                                "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_MISSED + "," +
                                "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.REQUIRED_PARAM_MISSED_CODE)) + "," +
                                "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_MISSED_MESSAGE + "device_os_version") +
                          "}");

                return;
            }

            // user_system_id
            String user_system_id;

            try {
                user_system_id = jsonObject.getString("user_system_id");

                if (user_system_id.isEmpty()) {
                    log.info("Response: " +
                                "{" +
                                    "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY + "," +
                                    "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY_CODE)) + "," +
                                    "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY_MESSAGE + "user_system_id") +
                                "}");
                    out.print("{" +
                                    "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY + "," +
                                    "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY_CODE)) + "," +
                                    "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY_MESSAGE + "user_system_id") +
                              "}");

                    return;
                }
            } catch (Exception e) {
                log.info("Response: " +
                            "{" +
                                "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_MISSED + "," +
                                "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.REQUIRED_PARAM_MISSED_CODE)) + "," +
                                "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_MISSED_MESSAGE + "user_system_id") +
                            "}");
                out.print("{" +
                                "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_MISSED + "," +
                                "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.REQUIRED_PARAM_MISSED_CODE)) + "," +
                                "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_MISSED_MESSAGE + "user_system_id") +
                          "}");

                return;
            }

            // access_token
            String access_token;

            try {
                access_token = jsonObject.getString("access_token");

                if (access_token.isEmpty()) {
                    log.info("Response: " +
                                "{" +
                                    "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY_CODE + "," +
                                    "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.NEMOAPP_MESSAGE_TITLE_INVALID) + "," +
                                    "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY_MESSAGE + "access_token") +
                                "}");
                    out.print("{" +
                                    "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY_CODE + "," +
                                    "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.NEMOAPP_MESSAGE_TITLE_INVALID) + "," +
                                    "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY_MESSAGE + "access_token") +
                              "}");

                    return;
                } else {
                    // Get access token for current login session
                    log.info("Start to validate access token");
                    AccessTokenForm accessToken = new LoginLayer().validateAccessToken(app_id, app_version, app_language, device_id, device_os, device_os_version, user_system_id, access_token);
                    log.info("Completed validation access token");

                    int errorCode = accessToken.getError();
                    if (errorCode != 0) {
                        String messageTitle = ResponseCodeFactory.getMessageTitleByCode(errorCode);

                        log.info("Response: " +
                                    "{" +
                                        "\"error\":" + accessToken.getError() + "," +
                                        "\"message_title\":" + DataFormat.getJsonValueFormat(messageTitle) + "," +
                                        "\"message\":" + DataFormat.getJsonValueFormat(accessToken.getMessage()) +
                                    "}");

                        out.print("{" +
                                        "\"error\":" + accessToken.getError() + "," +
                                        "\"message_title\":" + DataFormat.getJsonValueFormat(messageTitle) + "," +
                                        "\"message\":" + DataFormat.getJsonValueFormat(accessToken.getMessage()) +
                                  "}");

                        return;
                    }
                }
            } catch (Exception e) {
                log.info("Response: " +
                            "{" +
                                "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_MISSED_CODE + "," +
                                "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.NEMOAPP_MESSAGE_TITLE_INVALID) + "," +
                                "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_MISSED_MESSAGE + "access_token") +
                            "}");
                out.print("{" +
                                "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_MISSED_CODE + "," +
                                "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.NEMOAPP_MESSAGE_TITLE_INVALID) + "," +
                                "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_MISSED_MESSAGE + "access_token") +
                          "}");

                return;
            }

            // employee_system_id
            String employee_system_id;

            try {
                employee_system_id = jsonObject.getString("employee_system_id");

                if (employee_system_id.isEmpty()) {
                    log.info("Response: " +
                                "{" +
                                    "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY + "," +
                                    "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY_CODE)) + "," +
                                    "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY_MESSAGE + "employee_system_id") +
                                "}");
                    out.print("{" +
                                    "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY + "," +
                                    "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY_CODE)) + "," +
                                    "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_VALUE_EMPTY_MESSAGE + "employee_system_id") +
                              "}");

                    return;
                }
            } catch (Exception e) {
                    log.info("Response: " +
                                "{" +
                                    "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_MISSED + "," +
                                    "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.REQUIRED_PARAM_MISSED_CODE)) + "," +
                                    "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_MISSED_MESSAGE + "employee_system_id") +
                                "}");
                    out.print("{" +
                                    "\"error\":" + ResponseCodeFactory.REQUIRED_PARAM_MISSED + "," +
                                    "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.REQUIRED_PARAM_MISSED_CODE)) + "," +
                                    "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.REQUIRED_PARAM_MISSED_MESSAGE + "employee_system_id") +
                              "}");

                    return;
            }

            log.info("Start to get ${sanitizationModelClassName} list");
            result = layer.get${modelClassName}(app_id, app_version, app_language, device_id, device_os, device_os_version, user_system_id, employee_system_id);
            log.info("Completed getting ${sanitizationModelClassName} list");

            String responseJSONString = "";

            if (result.getError() == 0) {
                if (result.getData() != null && !result.getData().isEmpty()) {
                    // Convert coaching outlet list into JSON string
                    responseJSONString = result.getData().stream().map(coachingOutlet ->
                        "{\"id\":" + DataFormat.getJsonValueFormat(coachingOutlet.getId()) + "," +
                        "\"name\":" + DataFormat.getJsonValueFormat(coachingOutlet.getName()) + "}")
                    .collect(Collectors.joining(","));
                }

                responseJSONString =
                    "{" +
                        "\"error\":" + result.getError() + "," +
                        "\"message\":" + DataFormat.getJsonValueFormat(result.getMessage()) + "," +
                        "\"message_title\": " + DataFormat.getJsonValueFormat(result.getMessageTitle()) + "," +
                        "\"data\":[" + responseJSONString + "]" +
                    "}";
            } else {
                responseJSONString =
                    "{" +
                        "\"error\":" + result.getError() + "," +
                        "\"message\":" + DataFormat.getJsonValueFormat(result.getMessage()) + "," +
                        "\"message_title\": " + DataFormat.getJsonValueFormat(result.getMessageTitle()) +
                    "}";
            }

            // Response
            log.info("Response: " + responseJSONString);
            out.print(responseJSONString);

            return;
        } catch (Exception e) {
            log.error("Exception while getting ${sanitizationModelClassName}: " + e.getMessage());
            log.info("Response: " +
                        "{" +
                            "\"error\":" + ResponseCodeFactory.PROCESSING_ERROR_CODE + "," +
                            "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.NEMOAPP_MESSAGE_TITLE_INVALID) + "," +
                            "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.PROCESSING_ERROR_MESSAGE + e.getMessage()) +
                        "}");
            out.print("{" +
                            "\"error\":" + ResponseCodeFactory.PROCESSING_ERROR_CODE + "," +
                            "\"message_title\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.NEMOAPP_MESSAGE_TITLE_INVALID) + "," +
                            "\"message\":" + DataFormat.getJsonValueFormat(ResponseCodeFactory.PROCESSING_ERROR_MESSAGE + e.getMessage()) +
                      "}");

            return;
        }
    }
}
