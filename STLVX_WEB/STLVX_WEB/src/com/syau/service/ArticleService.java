package com.syau.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.syau.dao.ArticleDao;
import com.syau.po.ArticleBean;
import com.syau.po.ArticleChapterBean;
import com.syau.po.ArticleFileAndViewBean;
import com.syau.po.ArticleFileBean;
import com.syau.po.ArticleFileChapterAndViewBean;
import com.syau.po.ArticleFileChapterBean;
import com.syau.po.ArticleFileOrderBean;
import com.syau.po.FileBean;
import com.syau.po.PraxisAnserBean;
import com.syau.po.QuestionReplyBean;

@Component
public class ArticleService {
	@Resource
	private ArticleDao dao;

	public ArticleDao getDao() {
		return dao;
	}

	public void setDao(ArticleDao dao) {
		this.dao = dao;
	}

	public String addArticle(ArticleBean articleBean) {
		return dao.addArticle(articleBean);
	}

	public List<ArticleBean> selectActicleById(String acticleId) {
		return dao.selectArticleById(acticleId);
	}

	public List<ArticleBean> selectNewArticle() {
		return dao.selectNewArticle();
	}

	/**
	 * 查询理论教学文章列表（首页用）
	 */
	public List<ArticleBean> selectLljxActicleForIndex() {
		return dao.selectLljxActicleForIndex();
	}

	public List<ArticleBean> selectSkspActicleForIndex() {
		return dao.selectSkspActicleForIndex();
	}

	public List<ArticleBean> selectKcalActicleForIndex() {
		return dao.selectKcalActicleForIndex();
	}

	public List<ArticleBean> selectKzxxActicleForIndex() {
		return dao.selectKzxxActicleForIndex();
	}

	public List<FileBean> selectTpkForIndex(int fileType) {
		return dao.selectTpkForIndex(fileType);
	}

	public List<FileBean> selectDttpActicleForIndex() {
		return dao.selectDttpActicleForIndex();
	}

	/**
	 * 按文章的ID 查询文章的章节及其 文件的路径（文件的路径可以没有但是章节必须有）
	 * 
	 * @param articleId
	 *            文章id
	 * @return 文章的结果集
	 */
	public List<ArticleFileChapterAndViewBean> selectArticleAndFiChaByid(
			String articleId) {
		return dao.selectArticleAndFiChaByid(articleId);
	}

	/**
	 * 通过文章的ID删除文章（伦理消除）
	 * @param articleId
	 * @return 返回值为1删除成功 为0删除失败
	 */
	public String deleteByArticleId(String articleId) {
		return dao.deleteByArticleId(articleId);
	}
	
	/**
	 * 通过文章的ID删除文章（伦理消除）
	 * @param articleId
	 * @return 返回值为1删除成功 为0删除失败
	 */
	public String deleteVideoByArticleId(String articleId) {
		return dao.deleteVideoByArticleId(articleId);
	}

	/**
	 * 通过文件的ID删除文件（PS：伦理消除）
	 * 
	 * @param articleId
	 * @return 返回值为1删除成功 为0删除失败
	 */
	public String deleteByFileId(String FileId) {
		return dao.deleteByFileId(FileId);
	}

	/**
	 * 用于查询更多理论教学
	 * 
	 * @return
	 */
	public List<ArticleBean> selectMoreTheoryArticle() {
		return dao.selectMoreTheoryArticle();
	}

	/**
	 * 按类和章节查询文章文件章节
	 * 
	 * @return
	 */
	public List<ArticleFileChapterBean> selectArticleAndFiChaByKind(int kind,
			String ChapterId) {
		return dao.selectArticleAndFiChaByKind(kind, ChapterId);
	}

	/**
	 * 用于查询在线测试用
	 * 
	 * @param kind 文章的种类
	 * @return
	 */
	public List<ArticleBean> selectOnlineTest(int kind, String chapterId) {
		return dao.selectOnlineTest(kind, chapterId);
	}

	/**
	 * 查询所有文章的章节
	 * 
	 * @return
	 */
	public List<ArticleChapterBean> selectActicleChapter() {
		return dao.selectActicleChapter();
	}

	/**
	 * 按文章的ID和文件的类型 查询文章及其章节及其文件的路径
	 * 
	 * @param articleid
	 * @param filetype
	 * @return
	 */

	public List<ArticleFileChapterBean> selectArticleDetailByIdType(
			String articleid, int filetype) {
		return dao.selectArticleDetailByIdType(articleid, filetype);
	}

	/**
	 * 查询习题用
	 * 
	 * @param articleid
	 * @return
	 */
	public List<PraxisAnserBean> selectExercises(String articleid) {
		return dao.selectExercises(articleid);
	}

	/**
	 * 查询课程概要用
	 * 
	 * @return
	 */
	public List<ArticleBean> selectEcProDeActicle() {
		return dao.selectEcProDeActicle();
	}

	/**
	 * 查询课程概要用
	 * 
	 * @return
	 */
	public List<ArticleBean> selectCourseOverview() {
		return dao.selectCourseOverview();
	}

	/**
	 * 按种类查询文章的图片及其章节
	 * 
	 * @param kind
	 *            文章的种类
	 * @return
	 */
	public List<ArticleFileChapterBean> selectArticleAndChaFilByKind(int kind) {
		return dao.selectArticleAndChaFilByKind(kind);
	}

	/**
	 * 按文章的kind查询文章以及文章的文件的类型为图片
	 * 
	 * @param kind
	 * @return
	 */
	public List<ArticleFileBean> selectArticleAndPicbykind(int kind) {
		return dao.selectArticleAndPicbykind(kind);
	}

	/**
	 * 按种类查询文章以及文章的所有文件
	 * 
	 * @param kind
	 * @return
	 */
	public List<ArticleFileBean> selectArticleAndAllFilebykind(int kind) {
		return dao.selectArticleAndAllFilebykind(kind);
	}

	/**
	 * 按文章的种类和文章id还有文件的类型查询文章（不查询文章的章节信息）
	 * 
	 * @param kind
	 * @param articleid
	 * @param filetype
	 * @return
	 */
	public List<ArticleFileAndViewBean> selectArticleAndFileById(String articleid,
			int filetype) {
		return dao.selectArticleAndFileById(articleid, filetype);
	}

	/**
	 * 用于查询教育中的文章
	 * 
	 * @return
	 */
	public List<ArticleBean> selectEducation() {

		return dao.selectEducation();
	}

	/**
	 * 通过文件的ID查询文件的信息
	 * 
	 * @param fileId
	 *            文件的ID
	 * @return
	 */
	public List<FileBean> selectFileDetailByFileId(String fileId) {
		return dao.selectFileDetailByFileId(fileId);
	}

	/**
	 * 按文章ID查询文章及其文章的文件
	 * 
	 * @param articleId
	 *            文章id
	 * @return
	 */
	public List<ArticleFileBean> selectArticleAndFileById(String articleId,
			String fileType) {
		return dao.selectArticleAndFileById(articleId, fileType);
	}

	/**
	 * 查询所有理论教学的文章以及文章的文件
	 * 
	 * @param objects
	 *            排序FLG 传值为排序不传值为默认的排序（ps：可以传参也可以不传参）
	 * @return
	 */
	public List<ArticleFileBean> selectTheoryTeachingArticle(Object... objects) {
		return dao.selectTheoryTeachingArticle(objects);
	}

	/**
	 * 用于查询学生的问题和老师的问题回答
	 * 
	 * @return
	 */
	public List<QuestionReplyBean> selectQuestionAndReply() {
		return dao.selectQuestionAndReply();
	}

	/**
	 * 用于插入学生的提问和老师的回答
	 * 
	 * @param listObject
	 */
	public void addQuestionAndReply(Object... listObject) throws Exception {
		dao.addQuestionAndReply(listObject);
	}

	/**
	 * 用于查询课程案例用
	 * 
	 * @param kind
	 *            文章的种类
	 * @return
	 */
	public List<ArticleFileBean> selectCourseCase(int kind) {
		return dao.selectCourseCase(kind);
	}

	/**
	 * 修改文章的信息
	 * 
	 * @return 返回值：0更新失败，1更新成功
	 */
	public String upDateArticle(ArticleFileBean article) throws Exception {
		return dao.upDateArticle(article);
	}

	/**
	 * 添加实体类用
	 * 
	 * @param listObjects
	 * @return 返回值：0添加失败，1添加成功
	 */
	public String addEntity(Object... listObjects) throws Exception {
		return dao.addEntity(listObjects);
	}

	/**
	 * 用于查询文章是否有和文件关联
	 * 
	 * @param articleid
	 *            文章的ID
	 * @param filetype
	 *            文件的类型0代表图片 1代表视频
	 * @return 返回值为<FileBean>反省的集合 有记录代表有关联没有代表没有
	 */
	public List<FileBean> selectFileExsit(String articleid) {
		return dao.selectFileExsit(articleid);
	}

	/**
	 * 用于修改文章所绑定的文件的信息
	 * 
	 * @param files
	 *            FileBean数组
	 */
	public String upDateFile(FileBean... files) throws Exception {
		return dao.upDateFile(files);
	}

	/**
	 * 删除文章的章节用
	 * 
	 * @return 返回0：更新失败 1：更新成功
	 */
	public String deleteChapter(ArticleChapterBean... chapters)
			throws Exception {
		return dao.deleteChapter(chapters);
	}

	/**
	 * 更新实体类用
	 * 
	 * @param objects
	 *            实体类的数组
	 * @return 返回0：更新失败 1：更新成功
	 */
	public String updateEntitys(Object... objects) throws Exception {
		return dao.updateEntitys(objects);
	}

	/**
	 * 用于更新Entity用
	 * 
	 * @param object
	 *            Entity对象
	 * @return 返回0：更新失败 1：更新成功
	 */
	public String updateEntity(Object object) throws Exception {
		return dao.updateEntity(object);
	}

	/**
	 * 保存或更新实体类用
	 * 
	 * @param objects
	 *            实体类数组
	 * @return 返回 1：成功 0：失败
	 * @throws Exception
	 */
	public String saveOrUpdate(Object... objects) throws Exception {
		return dao.saveOrUpdate(objects);
	}

	/**
	 * 用于查询将要编辑的理论文章
	 * 
	 * @param articleid
	 * @param fileType
	 * @return
	 */
	public List<ArticleFileOrderBean> selectEditerTheory(String articleid,
			int fileType) throws Exception {
		return dao.selectEditerTheory(articleid, fileType);
	}

	/**
	 * 用于删除互动教学的历史记录用
	 * 
	 * @param contentId
	 * @return
	 */
	public String deleteBycontentId(String contentId) throws Exception {
		return dao.deleteBycontentId(contentId);
	}

	/**
	 * 查询实体类
	 * 
	 * @param object
	 *            实体类对象
	 * @param Id
	 * @return
	 * @throws Exception
	 */
	public List<Object> getEntity(Object object, String Id) throws Exception {
		return dao.getEntity(object, Id);
	}

	/**
	 * 查询理论教学(手机版用)
	 */
	public List<ArticleBean> selectMobileTheoryTeaching() {
		return dao.selectMobileTheoryTeaching();
	}

	/**
	 * 按文件的类型查找文件
	 */
	public List<FileBean> selectFileByFileType(int fileType) {
		return dao.selectFileByFileType(fileType);
	}
}
