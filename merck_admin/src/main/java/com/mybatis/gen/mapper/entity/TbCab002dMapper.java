package com.mybatis.gen.mapper.entity;

import com.mybatis.gen.model.TbCab002d;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TbCab002dMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_CAB002D
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    int deleteByPrimaryKey(@Param("boardId") String boardId, @Param("postId") String postId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_CAB002D
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    int insert(TbCab002d record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_CAB002D
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    TbCab002d selectByPrimaryKey(@Param("boardId") String boardId, @Param("postId") String postId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_CAB002D
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    List<TbCab002d> selectAll();

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_CAB002D
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    int updateByPrimaryKey(TbCab002d record);
}