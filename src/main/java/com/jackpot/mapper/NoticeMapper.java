package com.jackpot.mapper;

import java.util.List;

import com.jackpot.domain.AdminVO;
import com.jackpot.domain.Criteria;
import com.jackpot.domain.NoticeVO;

public interface NoticeMapper {
	public NoticeVO read(Long noticeId); // PK 전달
	
	public void insert(NoticeVO notice);
	
	public int update(NoticeVO notice);
	
	public int delete(Long noticeId); // PK 전달
	
	public List<NoticeVO> getList();
	
	public List<NoticeVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);

	public List<AdminVO> getAdminLoginIdMapper(AdminVO admin);
}
