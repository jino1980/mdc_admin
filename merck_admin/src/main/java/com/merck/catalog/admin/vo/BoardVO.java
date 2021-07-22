package com.merck.catalog.admin.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class BoardVO implements Serializable {
	
    private static final long serialVersionUID = 2718980056309836856L;
    
    int id;
	String board_content;
	String password;
	String writer;
	Date insDate;
	
    @Override
    public String toString() {
        return "BoardVO [id=" + id + ", board_content=" + board_content + ", password=" + password + ", writer="
                + writer + ", insDate=" + insDate + "]";
    }
}
