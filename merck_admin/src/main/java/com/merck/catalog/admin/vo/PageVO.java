package com.merck.catalog.admin.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@Getter @Setter @Accessors(chain=true)
public class PageVO {
    
    // ------------------startContent------------------- 11th
    // ------------------------------------------------- 12th
    // ------------------------------------------------- 13th
    // ------------------------------------------------- 14th
    // ------------------------------------------------- 15th (perPage = 5)
    // << [beginPage], [2], [requirePage], [4], [endPage] >>    ..... [51. totalPage]
    
    private int requirePage = 1;
    private int totalPage;
    private int beginPage;
    private int endPage;
    private int startContent;
    private int perPage;
    
    @Override
    public String toString() {
        return "PageVO [requirePage=" + requirePage + ", totalPage=" + totalPage + ", beginPage=" + beginPage
                + ", endPage=" + endPage + ", startContent=" + startContent + ", perPage=" + perPage + "]";
    }
    
}
