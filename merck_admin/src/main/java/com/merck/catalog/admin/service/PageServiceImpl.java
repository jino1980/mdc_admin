package com.merck.catalog.admin.service;

import org.springframework.stereotype.Service;

import com.merck.catalog.admin.vo.PageVO;

@Service("PageService")
public class PageServiceImpl implements PageService<PageVO> {

    @Override
    public void pagination(PageVO pageVO, int totalCount) {
        pagination(pageVO, totalCount, 5, 5);
    }

    @Override
    public void pagination(PageVO pageVO, int totalCount, int pageContents, int perPage) {
        int requirePage = pageVO.getRequirePage();  
        int totalPage = (totalCount%pageContents == 0 ? totalCount/pageContents : totalCount/pageContents+1); 
        int beginPage = (requirePage == perPage ? 1 : (requirePage - requirePage%perPage + 1)); 
        int flag = beginPage + perPage - 1; 
        int endPage = flag > totalPage ? totalPage : flag; 
        beginPage = beginPage > endPage ? endPage : beginPage; // 보정
        int startContent = pageContents*requirePage-pageContents; 
        // calculate done...
        pageVO
            .setRequirePage(requirePage)
            .setTotalPage(totalPage)
            .setBeginPage(beginPage)
            .setEndPage(endPage)
            .setStartContent(startContent)
            .setPerPage(perPage); // limit query 
    }
    

}
