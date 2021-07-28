package com.mybatis.gen.mapper.entity;

import com.mybatis.gen.model.TbCac001d;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TbCac001dMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_CAC001D
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    int deleteByPrimaryKey(@Param("boardId") String boardId, @Param("postId") String postId, @Param("pushRegNo") String pushRegNo);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_CAC001D
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    int insert(TbCac001d record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_CAC001D
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    TbCac001d selectByPrimaryKey(@Param("boardId") String boardId, @Param("postId") String postId, @Param("pushRegNo") String pushRegNo);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_CAC001D
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    List<TbCac001d> selectAll();

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TB_CAC001D
     *
     * @mbg.generated Wed Jul 28 11:31:26 KST 2021
     */
    int updateByPrimaryKey(TbCac001d record);
}