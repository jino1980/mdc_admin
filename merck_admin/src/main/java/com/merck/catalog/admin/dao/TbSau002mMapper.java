package com.merck.catalog.admin.dao;

import com.mybatis.gen.model.TbSau002m;
import java.util.List;

public interface TbSau002mMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_SAU002M
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    int deleteByPrimaryKey(String usrId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_SAU002M
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    int insert(TbSau002m record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_SAU002M
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    TbSau002m selectByPrimaryKey(String usrId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_SAU002M
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    List<TbSau002m> selectAll();

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_SAU002M
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    int updateByPrimaryKey(TbSau002m record);
}