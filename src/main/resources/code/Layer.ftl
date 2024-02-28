package ${layerPackage};

import java.sql.SQLException;

import org.apache.log4j.Logger;

import common.ResponseCodeFactory;
import ${daoClassPath};
import ${modelPackage}.Get${modelClassName};

/**
 * Layer for ${title}
 *
 * @author ${author}
 * @version ${version}
 */
public class ${layerClassName} {

    private static Logger log = Logger.getLogger("${layerClassName}.class");

    /**
    * Get ${sanitizationModelClassName}
    *
    * @param appId            App Id
    * @param appVersion       App Version
    * @param appLanguage      App Language
    * @param deviceId         Device Id
    * @param deviceOs         Device Os
    * @param deviceOsVersion  Device Os Version
    * @param userSystemId     User System Id
    * @param employeeSystemId Employee System Id
    *
    * @throws SQLException if an SQLException error occurs
    * @return a object of Get${modelClassName} class
    */
    public Get${modelClassName} get${modelClassName}(String appId, String appVersion, String appLanguage,
                                                 String deviceId, String deviceOs, String deviceOsVersion,
                                                 String userSystemId, String employeeSystemId) throws SQLException {
        Get${modelClassName} result = new Get${modelClassName}(ResponseCodeFactory.PROCESSING_ERROR_CODE,
                                                                ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.PROCESSING_ERROR_CODE),
                                                                ResponseCodeFactory.PROCESSING_UNKOWN_ERROR_MESSAGE);
        try {
            ${daoClassName} dao = new ${daoClassName}();
            result = dao.get${modelClassName}(appId, appVersion, appLanguage, deviceId, deviceOs, deviceOsVersion, userSystemId, employeeSystemId);
        } catch (Exception e) {
            log.error("Unable to get ${sanitizationModelClassName} list: " + e.getMessage());
            result = new Get${modelClassName}(ResponseCodeFactory.CONNECTION_ERROR_CODE,
                                              ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.CONNECTION_ERROR_CODE),
                                              ResponseCodeFactory.CONNECTION_ERROR_MESSAGE);
        }

        return result;
    }
}
