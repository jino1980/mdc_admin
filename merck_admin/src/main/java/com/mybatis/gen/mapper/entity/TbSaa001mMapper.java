package com.mybatis.gen.mapper.entity;

import com.mybatis.gen.model.TbSaa001m;
import java.util.List;

public interface TbSaa001mMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_SAA001M
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    int deleteByPrimaryKey(String cmmnCdId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_SAA001M
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    int insert(TbSaa001m record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_SAA001M
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    TbSaa001m selectByPrimaryKey(String cmmnCdId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_SAA001M
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    List<TbSaa001m> selectAll();

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_SAA001M
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    int updateByPrimaryKey(TbSaa001m record);
}