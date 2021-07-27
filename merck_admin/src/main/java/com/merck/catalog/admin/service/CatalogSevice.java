package com.merck.catalog.admin.service;

import java.util.List;

import com.merck.catalog.admin.vo.TbCaa001m;

public interface CatalogSevice extends CommonService<TbCaa001m> {
    public List getList(TbCaa001m vo);
}
