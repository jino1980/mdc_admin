package com.mybatis.gen.mapper.entity;

import com.mybatis.gen.model.TbCab001m;
import java.util.List;

public interface TbCab001mMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_CAB001M
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    int deleteByPrimaryKey(String boardId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_CAB001M
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    int insert(TbCab001m record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_CAB001M
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    TbCab001m selectByPrimaryKey(String boardId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_CAB001M
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    List<TbCab001m> selectAll();

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_CAB001M
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    int updateByPrimaryKey(TbCab001m record);
}