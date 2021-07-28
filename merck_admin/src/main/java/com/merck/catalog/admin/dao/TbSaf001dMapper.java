package com.merck.catalog.admin.dao;

import com.mybatis.gen.model.TbSaf001d;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TbSaf001dMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_SAF001D
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    int deleteByPrimaryKey(@Param("attchFileGrpId") String attchFileGrpId, @Param("attchFileId") String attchFileId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_SAF001D
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    int insert(TbSaf001d record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_SAF001D
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    TbSaf001d selectByPrimaryKey(@Param("attchFileGrpId") String attchFileGrpId, @Param("attchFileId") String attchFileId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_SAF001D
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    List<TbSaf001d> selectAll();

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_SAF001D
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    int updateByPrimaryKey(TbSaf001d record);
}