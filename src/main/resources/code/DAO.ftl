package ${daoPackage};

import db.DBConnection;

import oracle.jdbc.OracleTypes;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import common.ResponseCodeFactory;
import ${modelClassPath};
import ${modelPackage}.Get${modelClassName};

/**
 * DAO for ${title}
 *
 * @author ${author}
 * @version ${version}
 */
public class ${daoClassName} {

    private static Logger log = Logger.getLogger("${daoClassName}.class");

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
        DBConnection db = new DBConnection();
        Connection con = null;
        CallableStatement cs = null;
        ResultSet resultSet = null;

        try {
            con = db.getConnection();
            List<${modelClassName}> dataList = new ArrayList<>();

            log.info("Start to get ${sanitizationModelClassName}");
            cs = db.callableStatement("{CALL DB_STORED_PROCEDURE(?, ?, ?, ?, ?, ?, ?, ?, ?)}", con);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, appId);
            cs.setString(3, appVersion);
            cs.setString(4, appLanguage);
            cs.setString(5, deviceId);
            cs.setString(6, deviceOs);
            cs.setString(7, deviceOsVersion);
            cs.setString(8, userSystemId);
            cs.setString(9, employeeSystemId);
            cs.execute();
            log.info("Completed getting ${sanitizationModelClassName}");

            resultSet = (ResultSet) cs.getObject(1);

            while (resultSet.next()) {
               dataList.add(new ${modelClassName}(resultSet.getString("DB_COLUMN_ID"), resultSet.getString("DB_COLUMN_NAME")));
            }

            if (!dataList.isEmpty()) {
                result = new Get${modelClassName}(0, "Thành công", "Tải dữ liệu thành công", dataList);
            } else {
                result = new Get${modelClassName}(0, "Thông báo", "Không tìm thấy dữ liệu", dataList);
            }
        } catch (Exception e) {
            log.error("Exception while getting ${sanitizationModelClassName} list: " + e.getMessage());
            result = new Get${modelClassName}(ResponseCodeFactory.CONNECTION_ERROR_CODE,
                                              ResponseCodeFactory.getMessageTitleByCode(ResponseCodeFactory.CONNECTION_ERROR_CODE),
                                              ResponseCodeFactory.CONNECTION_ERROR_MESSAGE);
        } finally {
            db.closeConnection(con, cs, resultSet);
        }

        return result;
    }
}
