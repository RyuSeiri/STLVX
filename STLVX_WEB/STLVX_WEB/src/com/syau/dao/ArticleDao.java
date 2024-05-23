package com.syau.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Component;

import com.syau.po.ArticleBean;
import com.syau.po.ArticleChapterBean;
import com.syau.po.ArticleFileAndViewBean;
import com.syau.po.ArticleFileBean;
import com.syau.po.ArticleFileChapterAndViewBean;
import com.syau.po.ArticleFileChapterBean;
import com.syau.po.ArticleFileOrderBean;
import com.syau.po.ArticleFileRelationBean;
import com.syau.po.FileBean;
import com.syau.po.PraxisAnserBean;
import com.syau.po.PraxisBean;
import com.syau.po.QuestionReplyBean;

@Component
@SuppressWarnings("all")
public class ArticleDao {
	@Resource
	private HibernateTemplate hibernateTemplate;

	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

	/**
	 * 添加文章用
	 * 
	 * @param articleBean
	 * @return
	 */
	public String addArticle(ArticleBean articleBean) {
		try {
			hibernateTemplate.save(articleBean);
		} catch (Exception e) {
			e.printStackTrace();
			return "0";
		}
		return "1";
	}

	/**
	 * 返回值为1删除成功 为0删除失败
	 * 
	 * @param articleId
	 * @return
	 */
	public String deleteByArticleId(String articleId) {
		Session session = hibernateTemplate.getSessionFactory().openSession();
		final String sql = "update ArticleBean set delFlg = '1' where sArticleId = '"
				+ articleId + "'";
		try {
			session.beginTransaction();
			session.createQuery(sql).executeUpdate();
			session.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
			closeSession(session);
			return "0";
		}
		closeSession(session);
		return "1";
	}
	
	/**
	 * 返回值为1删除成功 为0删除失败
	 * 
	 * @param articleId 文章ID
	 * @return
	 */
	public String deleteVideoByArticleId(String articleId) {
		Session session = hibernateTemplate.getSessionFactory().openSession();
		final String sql = " SELECT * FROM tb_article_file WHERE SARTICLEID = '"
				+ articleId + "' ";
		List<ArticleFileRelationBean> executeFind=null;
		try {
			executeFind = hibernateTemplate.executeFind(new HibernateCallback() {
				public Object doInHibernate(Session session)
						throws HibernateException, SQLException {
					SQLQuery query = session.createSQLQuery(sql);
					return query.addEntity(ArticleFileRelationBean.class).list();
				}
			});
			if (executeFind != null) {
				for (ArticleFileRelationBean articleFileRelationBean : executeFind) {
					session.createQuery(
							"DELETE FROM FileBean WHERE FILE_ID='"
									+ articleFileRelationBean.getFileId() + "'")
							.executeUpdate();
					hibernateTemplate.delete(articleFileRelationBean);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			closeSession(session);
			return "0";
		}
		closeSession(session);
		return "1";
	}

	/**
	 * 返回值为1删除成功 为0删除失败
	 * 
	 * @param articleId
	 * @return
	 */
	public String deleteByFileId(String FileId) {
		Session session = hibernateTemplate.getSessionFactory().openSession();
		final String sql = "update FileBean set DEL_FLG = '1' where  FILE_ID= '"
				+ FileId + "'";
		try {
			session.beginTransaction();
			session.createQuery(sql).executeUpdate();
			session.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
			closeSession(session);
			return "0";
		}
		closeSession(session);
		return "1";
	}

	public List<ArticleBean> selectArticleById(String articleId) {
		final String sql = "select * from TB_ARTICLE where DEL_FLG = 0 and SARTICLEID = '"
				+ articleId + "'";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(ArticleBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	public List<ArticleBean> selectNewArticle() {
		final String sql = "select * from TB_ARTICLE where DEL_FLG = 0 order by DMAKETIME desc limit 1";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(ArticleBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	/**
	 * 查询理论教学文章列表（首页用）
	 */
	public List<ArticleBean> selectLljxActicleForIndex() {
		final String sql = "select * from TB_ARTICLE where DEL_FLG = 0 and IARTICLEKIND IN(5, 6, 7) order by DMAKETIME desc ";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(ArticleBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	/**
	 * 查询授课视频文章列表（首页用）
	 * 
	 * @return
	 */
	public List<ArticleBean> selectSkspActicleForIndex() {
		final String sql = "select * from TB_ARTICLE where DEL_FLG = 0 and IARTICLEKIND = 9 order by DMAKETIME desc";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(ArticleBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	/**
	 * 查询课程案例文章列表（首页用）
	 * 
	 * @return
	 */
	public List<ArticleBean> selectKcalActicleForIndex() {
		final String sql = "SELECT tb_article.SARTICLEID,"
				+ "tb_article.STITLE,"
				+ "tb_article.IARTICLEKIND,"
				+ "tb_article.SAUTHORID,"
				+ "tb_article.DMAKETIME,"
				+ "TB_ARTICLE.SCONTENT,"
				+ "TB_ARTICLE.DEL_FLG,"
				+ "ifnull(t.FILE_PATH,'') AS 'filepath' "
				+ "FROM TB_ARTICLE "
				+ "LEFT JOIN "
				+ "(SELECT tb_file.*,tb_article_file.SARTICLEID from tb_file inner join tb_article_file on tb_article_file.FILE_ID= tb_file.FILE_ID where FILE_TYPE=0 "
				+ "AND TB_FILE.DEL_FLG = 0 ) t "
				+ " ON TB_ARTICLE.SARTICLEID = t.SARTICLEID "
				+ "LEFT JOIN "
				+ "(SELECT tb_file.*,tb_article_file.SARTICLEID from tb_file inner join tb_article_file on tb_article_file.FILE_ID= tb_file.FILE_ID where FILE_TYPE=1 "
				+ "AND TB_FILE.DEL_FLG = 0 ) t1 "
				+ "ON TB_ARTICLE.SARTICLEID = t1.SARTICLEID "
				+ "WHERE TB_ARTICLE.DEL_FLG = 0 AND IARTICLEKIND = '14' "
				+ "ORDER BY DMAKETIME DESC ";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(ArticleBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	/**
	 * 查询扩展学习文章列表（首页用）
	 * 
	 * @return
	 */
	public List<ArticleBean> selectKzxxActicleForIndex() {
		final String sql = "SELECT tb_article.SARTICLEID,"
				+ "tb_article.STITLE,"
				+ "tb_article.IARTICLEKIND,"
				+ "tb_article.SAUTHORID,"
				+ "tb_article.DMAKETIME,"
				+ "TB_ARTICLE.SCONTENT,"
				+ "TB_ARTICLE.DEL_FLG,"
				+ "ifnull(t.FILE_PATH,'') AS 'filepath' "
				+ "FROM TB_ARTICLE "
				+ "LEFT JOIN "
				+ "(SELECT tb_file.*,tb_article_file.SARTICLEID from tb_file inner join tb_article_file on tb_article_file.FILE_ID= tb_file.FILE_ID where FILE_TYPE=0 "
				+ "AND TB_FILE.DEL_FLG = 0 ) t "
				+ " ON TB_ARTICLE.SARTICLEID = t.SARTICLEID "
				+ "LEFT JOIN "
				+ "(SELECT tb_file.*,tb_article_file.SARTICLEID from tb_file inner join tb_article_file on tb_article_file.FILE_ID= tb_file.FILE_ID where FILE_TYPE=1 "
				+ "AND TB_FILE.DEL_FLG = 0 ) t1 "
				+ "ON TB_ARTICLE.SARTICLEID = t1.SARTICLEID "
				+ "WHERE TB_ARTICLE.DEL_FLG = 0 AND IARTICLEKIND = '18' "
				+ "ORDER BY DMAKETIME DESC ";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(ArticleBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	/**
	 * 查询图片库列表（首页用）
	 */
	public List<FileBean> selectTpkForIndex(int fileType) {
		final String sql = "select * from TB_FILE where FILE_TYPE = '"
				+ fileType + "' and DEL_FLG = 0 order by FILE_ID desc limit 8";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(FileBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	/**
	 * 通过文件的ID查询文件的信息
	 * 
	 * @param fileId
	 *            文件的ID
	 */
	public List<FileBean> selectFileDetailByFileId(String fileId) {
		final String sql = "select * from  TB_FILE where FILE_ID='" + fileId
				+ "'";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(FileBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	/**
	 * 查询首页动态图片（首页用）
	 * 
	 * @return
	 */
	public List<FileBean> selectDttpActicleForIndex() {
		final String sql = "select * from TB_FILE where FILE_TYPE = 2 and DEL_FLG = 0 order by FILE_ID desc limit 8";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(FileBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	/**
	 * 按文章的kind查询文章以及文章的文件的类型为图片
	 * 
	 * @param kind
	 * @return
	 */
	public List<ArticleFileBean> selectArticleAndPicbykind(int kind) {
		final String sql = "select tb_article.SARTICLEID,"
				+ "tb_article.STITLE,"
				+ "tb_article.IARTICLEKIND,"
				+ "tb_article.SAUTHORID,"
				+ "tb_article.DMAKETIME,"
				+ "TB_ARTICLE.SCONTENT,"
				+ "TB_ARTICLE.DEL_FLG,"
				+ "ifnull(t.FILE_PATH, '') AS 'filepath',"
				+ "ifnull(t.FILE_TYPE, '') AS 'FILE_TYPE' "
				+ "FROM TB_ARTICLE "
				+ "LEFT JOIN (SELECT tb_file.*,tb_article_file.SARTICLEID from tb_file inner join tb_article_file on tb_article_file.FILE_ID= tb_file.FILE_ID where FILE_TYPE=0 "
				+ "AND TB_FILE.DEL_FLG = 0 ) t "
				+ "ON TB_ARTICLE.SARTICLEID = t.SARTICLEID "
				+ "where TB_ARTICLE.DEL_FLG = 0  and IARTICLEKIND = '" + kind
				+ "' order by DMAKETIME desc ";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(ArticleFileBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	/**
	 * 按种类查询文章的图片及其章节
	 * 
	 * @param kind
	 *            文章的种类
	 * @return
	 */
	public List<ArticleFileChapterBean> selectArticleAndChaFilByKind(int kind) {
		final String sql = "select tb_article.SARTICLEID,"
				+ "tb_article.STITLE,"
				+ "tb_article.IARTICLEKIND,"
				+ "tb_article.SAUTHORID,"
				+ "tb_article.DMAKETIME,"
				+ "TB_ARTICLE.SCONTENT,"
				+ "ifnull(t.FILE_PATH, '') AS filepath,"
				+ "ifnull(t.FILE_TYPE, '') AS FILE_TYPE,"
				+ "tb_chapter.CHAPTER_ID,"
				+ "tb_chapter.CHAPTER_INFO "
				+ "from TB_ARTICLE "
				+ "LEFT JOIN (SELECT tb_file.*,tb_article_file.SARTICLEID from tb_file inner join tb_article_file on tb_article_file.FILE_ID= tb_file.FILE_ID where FILE_TYPE=0 "
				+ "AND TB_FILE.DEL_FLG = 0 ) t "
				+ "ON TB_ARTICLE.SARTICLEID = t.SARTICLEID "
				+ "INNER JOIN tb_article_chapter on TB_ARTICLE.SARTICLEID=tb_article_chapter.SARTICLEID "
				+ "INNER JOIN tb_chapter ON tb_article_chapter.CHAPTER_ID=tb_chapter.CHAPTER_ID "
				+ " where TB_ARTICLE.DEL_FLG = 0  and IARTICLEKIND = '" + kind
				+ "' " + "order by DMAKETIME desc ";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(ArticleFileChapterBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	/**
	 * 按类和章节查询文章图片章节
	 * 
	 * @return
	 */
	public List<ArticleFileChapterBean> selectArticleAndFiChaByKind(int kind,
			String chapterId) {
		final String sql = "SELECT TB_ARTICLE.SARTICLEID,"
				+ "TB_ARTICLE.STITLE,"
				+ "TB_ARTICLE.IARTICLEKIND,"
				+ "TB_ARTICLE.SAUTHORID,"
				+ "TB_ARTICLE.DMAKETIME,"
				+ "TB_ARTICLE.SCONTENT,"
				+ "ifnull(t.FILE_PATH, '') AS 'filepath',"
				+ "ifnull(t.FILE_TYPE, '') AS 'FILE_TYPE',"
				+ "tb_chapter.CHAPTER_ID,"
				+ "tb_chapter.CHAPTER_INFO "
				+ "FROM TB_ARTICLE "
				+ "LEFT JOIN (SELECT tb_file.*,tb_article_file.SARTICLEID from tb_file inner join tb_article_file on tb_article_file.FILE_ID= tb_file.FILE_ID where FILE_TYPE=0 "
				+ "AND TB_FILE.DEL_FLG = 0 ) t "
				+ "ON TB_ARTICLE.SARTICLEID = t.SARTICLEID "
				+ "INNER JOIN tb_article_chapter on TB_ARTICLE.SARTICLEID=tb_article_chapter.SARTICLEID "
				+ "INNER JOIN tb_chapter ON tb_article_chapter.CHAPTER_ID=tb_chapter.CHAPTER_ID  AND tb_chapter.DEL_FLG=0 "
				+ "where TB_ARTICLE.DEL_FLG = 0  and tb_article.IARTICLEKIND = '"
				+ kind + "' and tb_chapter.CHAPTER_ID='" + chapterId + "' "
				+ "order by DMAKETIME,CHAPTER_INFO ASC";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(ArticleFileChapterBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	public List<ArticleBean> selectOnlineTest(int kind, String chapterId) {
		final String sql = "SELECT TB_ARTICLE.SARTICLEID,"
				+ "TB_ARTICLE.STITLE,"
				+ "TB_ARTICLE.IARTICLEKIND,"
				+ "TB_ARTICLE.SAUTHORID,"
				+ "TB_ARTICLE.DMAKETIME,"
				+ "TB_ARTICLE.SCONTENT,"
				+ "TB_ARTICLE.DEL_FLG,"
				+ "'' AS filepath "
				+ "FROM TB_ARTICLE "
				+ "where TB_ARTICLE.DEL_FLG = 0  and tb_article.IARTICLEKIND = '"
				+ kind + "' and TB_ARTICLE.SCONTENT='" + chapterId + "' "
				+ "order by DMAKETIME ASC";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(ArticleBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	/**
	 * 查询更多理论教学 文章(所有文章)
	 * 
	 * @return
	 */
	public List<ArticleBean> selectMoreTheoryArticle() {
		final String sql = "select * from TB_ARTICLE where DEL_FLG = 0 and IARTICLEKIND IN(5, 6, 7, 8, 10) order by DMAKETIME desc";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(ArticleBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	/**
	 * 查询所有文章的章节
	 * 
	 * @return
	 */
	public List<ArticleChapterBean> selectActicleChapter() {
		final String sql = "SELECT * FROM TB_CHAPTER WHERE DEL_FLG = 0 ORDER BY CAST(CHAPTER_ID AS SIGNED) ASC";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(ArticleChapterBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	/**
	 * 按文章的ID 查询文章的章节及其 文件的路径（文件的路径可以没有但是章节必须有）
	 * 
	 * @param articleId
	 *            文章id
	 * @return
	 */
	public List<ArticleFileChapterAndViewBean> selectArticleAndFiChaByid(
			String articleId) {
		final String sql = "SELECT "
				+ "tb_article.SARTICLEID,"
				+ "tb_article.STITLE,"
				+ "tb_article.IARTICLEKIND,"
				+ "tb_article.SAUTHORID,"
				+ "tb_article.DMAKETIME,"
				+ "TB_ARTICLE.SCONTENT,"
				+ "ifnull(t.FILE_PATH, '') AS 'filepath',"
				+ "ifnull(t.FILE_TYPE, '') AS 'FILE_TYPE',"
				+ "tb_chapter.CHAPTER_ID,"
				+ "tb_chapter.CHAPTER_INFO, "
				+ "ifnull(tb_courseoverview.ARTICLE_OVERVIEWS,0) AS 'ARTICLE_OVERVIEWS' "
				+ "FROM TB_ARTICLE "
				+ "LEFT JOIN (SELECT tb_file.*,tb_article_file.SARTICLEID from tb_file inner join tb_article_file on tb_article_file.FILE_ID= tb_file.FILE_ID where FILE_TYPE=0 "
				+ "AND TB_FILE.DEL_FLG = 0 ) t "
				+ "ON TB_ARTICLE.SARTICLEID = t.SARTICLEID "
				+ "INNER JOIN tb_article_chapter on TB_ARTICLE.SARTICLEID=tb_article_chapter.SARTICLEID "
				+ "INNER JOIN tb_chapter ON tb_article_chapter.CHAPTER_ID=tb_chapter.CHAPTER_ID and tb_chapter.DEL_FLG=0 "
				+ "LEFT JOIN tb_courseoverview ON TB_ARTICLE.SARTICLEID=tb_courseoverview.SARTICLEID "
				+ "where TB_ARTICLE.DEL_FLG = 0 "
				+ "and tb_article.SARTICLEID='" + articleId + "' "
				+ "order by DMAKETIME,CHAPTER_INFO ASC";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(ArticleFileChapterAndViewBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
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
		final String sql = "SELECT tb_article.SARTICLEID,"
				+ "tb_article.STITLE,"
				+ "tb_article.IARTICLEKIND,"
				+ "tb_article.SAUTHORID,"
				+ "tb_article.DMAKETIME,"
				+ "TB_ARTICLE.SCONTENT,"
				+ "ifnull(TB_FILE.FILE_PATH, '') AS filepath,"
				+ "ifnull(TB_FILE.FILE_TYPE, '') AS FILE_TYPE "
				+ "from TB_ARTICLE "
				+ "LEFT JOIN (SELECT tb_file.*,tb_article_file.SARTICLEID from tb_file inner join tb_article_file on tb_article_file.FILE_ID= tb_file.FILE_ID where FILE_TYPE='"
				+ fileType + "' " + "AND TB_FILE.DEL_FLG = 0 ) t "
				+ "ON TB_ARTICLE.SARTICLEID = t.SARTICLEID "
				+ "where TB_ARTICLE.DEL_FLG = 0 "
				+ "and tb_article.SARTICLEID='" + articleId + "' "
				+ "order by DMAKETIME ASC";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(ArticleFileBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	/**
	 * 按文章的ID和文件的类型 查询文章及其章节及其文件的路径
	 * 
	 * @param articleid
	 *            文章的ID
	 * @param filetype
	 *            文件的类型
	 * @return
	 */
	public List<ArticleFileChapterBean> selectArticleDetailByIdType(
			String articleid, int filetype) {
		final String sql = "SELECT tb_article.SARTICLEID,"
				+ "tb_article.STITLE,"
				+ "tb_article.IARTICLEKIND,"
				+ "tb_article.SAUTHORID,"
				+ "tb_article.DMAKETIME,"
				+ "TB_ARTICLE.SCONTENT,"
				+ "ifnull(t.FILE_PATH, '') AS 'filepath',"
				+ "ifnull(t.FILE_TYPE, '') AS 'FILE_TYPE',"
				+ "tb_chapter.CHAPTER_ID,"
				+ "tb_chapter.CHAPTER_INFO "
				+ "FROM TB_ARTICLE "
				+ "LEFT JOIN (SELECT tb_file.*,tb_article_file.SARTICLEID from tb_file inner join tb_article_file on tb_article_file.FILE_ID= tb_file.FILE_ID where FILE_TYPE='"
				+ filetype+ "' "
				+ "AND TB_FILE.DEL_FLG = 0 ) t "
				+ "ON TB_ARTICLE.SARTICLEID = t.SARTICLEID "
				+ "INNER JOIN tb_article_chapter on TB_ARTICLE.SARTICLEID=tb_article_chapter.SARTICLEID "
				+ "INNER JOIN tb_chapter ON tb_article_chapter.CHAPTER_ID=tb_chapter.CHAPTER_ID and tb_chapter.DEL_FLG=0 "
				+ "where TB_ARTICLE.DEL_FLG = 0 "
				+ "and tb_article.SARTICLEID='" + articleid + "' "
				+ "order by DMAKETIME,CHAPTER_INFO ASC";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(ArticleFileChapterBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	/**
	 * 根据文章的ID查询问所属的章节的信息及其习题及其答案
	 * 
	 * @param articleid
	 * @return
	 */
	public List<PraxisAnserBean> selectExercises(String articleid) {
		final String sql = "SELECT "
				+ "tb_article.SARTICLEID,"
				+ "tb_article.STITLE,"
				+ "tb_article.IARTICLEKIND,"
				+ "tb_article.SAUTHORID,"
				+ "tb_article.DMAKETIME,"
				+ "tb_article.SCONTENT,"
				+ "tb_praxis.PRAXIS_INFO,"
				+ "tb_answer.ANSWER_INFO "
				+ "FROM tb_article "
				+ "LEFT JOIN tb_praxis on tb_article.SARTICLEID=tb_praxis.PRAXIS_ID and tb_praxis.DEL_FLG=0 "
				+ "LEFT JOIN tb_answer on tb_article.SARTICLEID=tb_answer.ANSWER_ID and tb_answer.DEL_FLG=0 "
				+ "where tb_article.DEL_FLG=0 "
				+ " and tb_article.SARTICLEID='" + articleid + "' ";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(PraxisAnserBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}

	}

	/**
	 * 用于查询生态产品设计
	 * 
	 * @return
	 */
	public List<ArticleBean> selectEcProDeActicle() {
		final String sql = "select * from TB_ARTICLE where DEL_FLG = 0 and IARTICLEKIND IN(11, 12, 13) order by DMAKETIME ";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(ArticleBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	/**
	 * 用于查询课程概况
	 * 
	 * @return
	 */
	public List<ArticleBean> selectCourseOverview() {
		final String sql = "select * from TB_ARTICLE where DEL_FLG = 0 and IARTICLEKIND IN(1,2,3,4) order by DMAKETIME ";
		;
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(ArticleBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	/**
	 * 用于查询课程案例用
	 * 
	 * @param kind
	 *            种类
	 * @return
	 */
	public List<ArticleFileBean> selectCourseCase(int kind) {
		final String sql = "SELECT tb_article.SARTICLEID,"
				+ "tb_article.STITLE,"
				+ "tb_article.IARTICLEKIND,"
				+ "tb_article.SAUTHORID,"
				+ "tb_article.DMAKETIME,"
				+ "TB_ARTICLE.SCONTENT,"
				+ "TB_ARTICLE.DEL_FLG,"
				+ "ifnull(t.FILE_PATH,'') AS 'filepath',"
				+ "ifnull(t.FILE_TYPE,'') AS 'FILE_TYPE' "
				+ "FROM TB_ARTICLE "
				+ "LEFT JOIN "
				+ "(SELECT tb_file.*,tb_article_file.SARTICLEID from tb_file inner join tb_article_file on tb_article_file.FILE_ID= tb_file.FILE_ID where FILE_TYPE=0 "
				+ "AND TB_FILE.DEL_FLG = 0 ) t "
				+ " ON TB_ARTICLE.SARTICLEID = t.SARTICLEID "
				+ "WHERE TB_ARTICLE.DEL_FLG = 0 AND TB_ARTICLE.IARTICLEKIND='"
				+ kind + "' " + "ORDER BY DMAKETIME DESC ";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(ArticleFileBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	/**
	 * 按种类查询文章以及文章的所有文件
	 * 
	 * @param kind
	 * @return
	 */
	public List<ArticleFileBean> selectArticleAndAllFilebykind(int kind) {
		final String sql = "select tb_article.SARTICLEID,"
				+ "tb_article.STITLE,"
				+ "tb_article.IARTICLEKIND,"
				+ "tb_article.SAUTHORID,"
				+ "tb_article.DMAKETIME,"
				+ "TB_ARTICLE.SCONTENT,"
				+ "TB_ARTICLE.DEL_FLG,"
				+ "ifnull(TB_FILE.FILE_PATH, '') AS filepath,"
				+ "ifnull(TB_FILE.FILE_TYPE, '') AS FILE_TYPE "
				+ "from TB_ARTICLE "
				+ "left join TB_ARTICLE_FILE on TB_ARTICLE.SARTICLEID = TB_ARTICLE_FILE.SARTICLEID "
				+ "left join TB_FILE on TB_FILE.FILE_ID = TB_ARTICLE_FILE.FILE_ID and TB_FILE.DEL_FLG = 0 "
				+ " where TB_ARTICLE.DEL_FLG = 0  and IARTICLEKIND = '" + kind
				+ "' order by DMAKETIME desc ";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(ArticleFileBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	/**
	 * 按文章id还有文件的类型查询文章（不查询文章的章节信息）
	 * 
	 * @param articleid
	 * @param filetype
	 * @return
	 */
	public List<ArticleFileAndViewBean> selectArticleAndFileById(String articleid,
			int filetype) {
		final String sql = "SELECT tb_article.SARTICLEID,"
				+ "tb_article.STITLE,"
				+ "tb_article.IARTICLEKIND,"
				+ "tb_article.SAUTHORID,"
				+ "tb_article.DMAKETIME,"
				+ "TB_ARTICLE.SCONTENT,"
				+ "ifnull(t.FILE_PATH, '') AS 'filepath',"
				+ "ifnull(t.FILE_TYPE, '') AS 'FILE_TYPE', "
				+ "ifnull(tb_courseoverview.ARTICLE_OVERVIEWS,0) AS 'ARTICLE_OVERVIEWS' "
				+ "FROM TB_ARTICLE "
				+ "LEFT JOIN (SELECT tb_file.*,tb_article_file.SARTICLEID from tb_file "
				+ "inner join tb_article_file on tb_article_file.FILE_ID= tb_file.FILE_ID where FILE_TYPE='"
				+ filetype + "' " + "AND TB_FILE.DEL_FLG = 0 ) t "
				+ "ON TB_ARTICLE.SARTICLEID = t.SARTICLEID "
				+ "LEFT JOIN tb_courseoverview ON TB_ARTICLE.SARTICLEID=tb_courseoverview.SARTICLEID "
				+ "where TB_ARTICLE.DEL_FLG = 0 and tb_article.SARTICLEID='"
				+ articleid + "' " + "order by DMAKETIME ASC";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(ArticleFileAndViewBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	/**
	 * 用于查询教育中的文章
	 * 
	 * @return
	 */
	public List<ArticleBean> selectEducation() {
		final String sql = "select * from TB_ARTICLE where DEL_FLG = 0 and IARTICLEKIND IN(15,16) order by DMAKETIME ";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(ArticleBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	/**
	 * 查询所有理论教学的文章以及文章的文件
	 * 
	 * @param objects
	 *            排序FLG 传值为排序不传值为默认的排序（ps：可以传参也可以不传参）
	 * @return
	 */
	public List<ArticleFileBean> selectTheoryTeachingArticle(Object... objects) {
		List result = null;
		if (objects.length > 0) {
			final String sql = "select tb_article.SARTICLEID,"
					+ "tb_article.STITLE,"
					+ "tb_article.IARTICLEKIND,"
					+ "tb_article.SAUTHORID,"
					+ "tb_article.DMAKETIME,"
					+ "TB_ARTICLE.SCONTENT,"
					+ "TB_ARTICLE.DEL_FLG,"
					+ "ifnull(t.FILE_PATH, '') AS filepath,"
					+ "ifnull(t.FILE_TYPE, '') AS FILE_TYPE "
					+ "from TB_ARTICLE "
					+ "LEFT JOIN (SELECT tb_file.*,tb_article_file.SARTICLEID from tb_file "
					+ "inner join tb_article_file on tb_article_file.FILE_ID= tb_file.FILE_ID where FILE_TYPE='1' "
					+ "AND TB_FILE.DEL_FLG = 0 ) t "
					+ "ON TB_ARTICLE.SARTICLEID = t.SARTICLEID "
					+ "LEFT JOIN tb_articleorder ON TB_ARTICLE.SARTICLEID=tb_articleorder.SARTICLEID "
					+ "where TB_ARTICLE.DEL_FLG = 0  and tb_article.IARTICLEKIND IN (5,6,7,8,9,10) "
					+ "order by tb_articleorder.ORDERINFO ASC ,tb_article.STITLE ASC, tb_article.DMAKETIME DESC";
			result = hibernateTemplate.executeFind(new HibernateCallback() {
				public Object doInHibernate(Session session)
						throws HibernateException, SQLException {
					SQLQuery query = session.createSQLQuery(sql);
					return query.addEntity(ArticleFileBean.class).list();
				}
			});
		} else {
			final String sql = "select tb_article.SARTICLEID,"
					+ "tb_article.STITLE,"
					+ "tb_article.IARTICLEKIND,"
					+ "tb_article.SAUTHORID,"
					+ "tb_article.DMAKETIME,"
					+ "TB_ARTICLE.SCONTENT,"
					+ "TB_ARTICLE.DEL_FLG,"
					+ "'' AS filepath,"
					+ "'' AS FILE_TYPE "
					+ "ifnull(t.FILE_PATH, '') AS filepath,"
					+ "ifnull(t.FILE_TYPE, '') AS FILE_TYPE "
					+ "from TB_ARTICLE "
					+ "LEFT JOIN (SELECT tb_file.*,tb_article_file.SARTICLEID from tb_file "
					+ "inner join tb_article_file on tb_article_file.FILE_ID= tb_file.FILE_ID where FILE_TYPE='1' "
					+ "AND TB_FILE.DEL_FLG = 0 ) t "
					+ "ON TB_ARTICLE.SARTICLEID = t.SARTICLEID "
					+ "where TB_ARTICLE.DEL_FLG = 0  and tb_article.IARTICLEKIND IN (5,6,7,8,9,10) "
					+ "order by DMAKETIME desc ";
			result = hibernateTemplate.executeFind(new HibernateCallback() {
				public Object doInHibernate(Session session)
						throws HibernateException, SQLException {
					SQLQuery query = session.createSQLQuery(sql);
					return query.addEntity(ArticleFileBean.class).list();
				}
			});
		}
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	/**
	 * 用于查询学生的问题和老师的回答
	 * 
	 * @return
	 */
	public List<QuestionReplyBean> selectQuestionAndReply() {
		final String sql = "SELECT t.CONTENT_ID," + "t.CONTENT,"
				+ "t.CONTENT_TYPE," + "t.TIME," + "t.DEL_FLG "
				+ "FROM tb_question_reply t " + "WHERE DEL_FLG = 0 "
				+ "ORDER BY TIME ASC";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(QuestionReplyBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	/**
	 * 用于插入学生的提问和老师的回答
	 * 
	 * @param listObject
	 */
	public void addQuestionAndReply(Object... listObject) throws Exception {
		if (null != listObject) {
			for (Object object : listObject) {
				try {
					hibernateTemplate.save(object);
				} catch (Exception e) {
					throw e;
				}
			}
		}
	}

	/**
	 * 修改文章的信息 返回值：0更新失败，1更新成功
	 * 
	 * @param
	 */
	public String upDateArticle(ArticleFileBean article) throws Exception {
		final String sql = "UPDATE  ArticleFileBean SET SCONTENT='"
				+ article.getsContent() + "'," + "STITLE='"
				+ article.getsTitle() + "' WHERE sArticleId ='"
				+ article.getsArticleId() + "'";
		Session session = hibernateTemplate.getSessionFactory().openSession();
		try {
			session.beginTransaction();
			session.createQuery(sql).executeUpdate();
			session.getTransaction().commit();
		} catch (Exception e) {
			session.getTransaction().rollback();
			closeSession(session);
			throw e;
		}
		closeSession(session);
		return "1";
	}

	/**
	 * 用于查询文章是否有和文件关联
	 * 
	 * @param articleid
	 *            文章的ID
	 * @param
	 * @return
	 */
	public List<FileBean> selectFileExsit(String articleid) {
		final String sql = "SELECT IFNULL(t.FILE_ID,'') AS 'FILE_ID',"
				+ "IFNULL(t.FILE_NAME,'') AS 'FILE_NAME',"
				+ "IFNULL(t.FILE_PATH,'') AS 'FILE_PATH',"
				+ "IFNULL(t.FILE_TYPE,'') AS 'FILE_TYPE',"
				+ "IFNULL(t.DEL_FLG,'') AS 'DEL_FLG' "
				+ "FROM TB_ARTICLE "
				+ "LEFT JOIN (SELECT TB_FILE.*, tb_article_file.SARTICLEID FROM TB_FILE "
				+ "INNER JOIN tb_article_file ON tb_article_file.FILE_ID = TB_FILE.FILE_ID "
				+ "WHERE TB_FILE.DEL_FLG = 0) t ON TB_ARTICLE.SARTICLEID = t.SARTICLEID "
				+ "WHERE TB_ARTICLE.DEL_FLG = 0 AND tb_article.SARTICLEID = '"
				+ articleid + "' " + "ORDER BY DMAKETIME ASC,t.FILE_TYPE DESC";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(FileBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	/**
	 * 用于修改文章所绑定的文件的信息
	 * 
	 * @param files
	 *            FileBean数组集合
	 */
	public String upDateFile(FileBean... files) throws Exception {
		Session session = hibernateTemplate.getSessionFactory().openSession();
		for (FileBean fileBean : files) {
			final String sql = "UPDATE  FileBean  SET FILE_PATH='"
					+ fileBean.getFilePath() + "',FILE_TYPE='"
					+ fileBean.getFileType() + "'  WHERE FILE_ID='"
					+ fileBean.getFileId() + "'";
			try {
				session.beginTransaction();
				session.createQuery(sql).executeUpdate();
				session.getTransaction().commit();
			} catch (Exception e) {
				session.getTransaction().rollback();
				closeSession(session);
				throw e;
			}
		}
		closeSession(session);
		return "1";
	}

	/**
	 * 添加实体类用
	 * 
	 * @param listObjects
	 * @return 返回值：0添加失败，1添加成功
	 */
	public String addEntity(Object... listObjects) throws Exception {
		if (null != listObjects) {
			try {
				for (Object object : listObjects) {
					hibernateTemplate.save(object);
					hibernateTemplate.flush();
				}
			} catch (Exception e) {
				return "0";
			}
		}
		return "1";
	}

	/**
	 * 删除文章的章节用
	 * 
	 * @return 1代表更新成功 、0代表更新失败
	 */
	public String deleteChapter(ArticleChapterBean... chapters)
			throws Exception {
		Session session = hibernateTemplate.getSessionFactory().openSession();
		for (ArticleChapterBean chapter : chapters) {
			final String sql = "DELETE FROM  ArticleChapterBean  WHERE CHAPTER_ID='"
					+ chapter.getChapterid() + "'";
			try {
				session.beginTransaction();
				session.createQuery(sql).executeUpdate();
				session.getTransaction().commit();
			} catch (Exception e) {
				session.getTransaction().rollback();
				closeSession(session);
				return "0";
			}
		}
		closeSession(session);
		return "1";
	}

	/**
	 * 更新实体类用
	 * 
	 * @param objects
	 *            实体类的数组
	 * @return 返回0：更新失败 1：更新成功
	 */
	public String updateEntitys(Object... objects) throws Exception {
		try {
			for (Object object : objects) {
				hibernateTemplate.update(object);
			}
		} catch (Exception e) {
			return "0";
		}
		hibernateTemplate.flush();
		return "1";
	}

	/**
	 * 用于更新Entity用
	 * 
	 * @param object
	 *            Entity对象
	 * @return 返回0：更新失败 1：更新成功
	 * @throws Exception
	 */
	public String updateEntity(Object object) throws Exception {
		try {
			hibernateTemplate.update(object);
		} catch (Exception e) {
			e.printStackTrace();
			return "0";
		}
		hibernateTemplate.flush();
		return "1";
	}

	/**
	 * 保存或更新实体类用
	 * 
	 * @param objects
	 *            实体类数组
	 * @return 返回 1：成功 0：失败
	 */
	public String saveOrUpdate(Object... objects) throws Exception {
		try {
			for (Object object : objects) {
				hibernateTemplate.saveOrUpdate(object);
			}
		} catch (Exception e) {
			return "0";
		}
		return "1";
	}

	/**
	 * 用于关闭session
	 * 
	 * @param session
	 */
	private void closeSession(Session session) {
		if (session != null)
			session.close();
	}

	/**
	 * 理论教学文章查询用
	 * 
	 * @param articleid
	 *            文章的ID
	 * @param fileType
	 *            文件的类型
	 * @return
	 */
	public List<ArticleFileOrderBean> selectEditerTheory(String articleid,
			int fileType) throws Exception {
		final String sql = "SELECT tb_article.SARTICLEID,"
				+ "tb_article.STITLE,"
				+ "tb_article.IARTICLEKIND,"
				+ "tb_article.SAUTHORID,"
				+ "tb_article.DMAKETIME,"
				+ "TB_ARTICLE.SCONTENT,"
				+ "ifnull(t.FILE_PATH, '') AS 'filepath',"
				+ "ifnull(t.FILE_TYPE, '') AS 'FILE_TYPE',"
				+ "ifnull(tb_articleorder.ORDERINFO,0) AS 'ORDERINFO' "
				+ "FROM TB_ARTICLE "
				+ "LEFT JOIN (SELECT tb_file.*,tb_article_file.SARTICLEID from tb_file "
				+ "inner join tb_article_file on tb_article_file.FILE_ID= tb_file.FILE_ID where FILE_TYPE='"
				+ fileType
				+ "' "
				+ "AND TB_FILE.DEL_FLG = 0 ) t "
				+ "ON TB_ARTICLE.SARTICLEID = t.SARTICLEID "
				+ "LEFT JOIN tb_articleorder ON tb_article.SARTICLEID=tb_articleorder.SARTICLEID "
				+ "where TB_ARTICLE.DEL_FLG = 0 and tb_article.SARTICLEID='"
				+ articleid + "' " + "order by DMAKETIME ASC";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(ArticleFileOrderBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	/**
	 * 用于删除互动教学的历史记录用
	 * 
	 * @param contentId
	 * @return
	 */
	public String deleteBycontentId(String contentId) throws Exception {
		Session session = hibernateTemplate.getSessionFactory().openSession();
		final String sql = "update QuestionReplyBean set DEL_FLG = '1' where CONTENT_ID = '"
				+ contentId + "'";
		try {
			session.beginTransaction();
			session.createQuery(sql).executeUpdate();
			session.getTransaction().commit();
		} catch (Exception e) {
			session.getTransaction().rollback();
			closeSession(session);
			return "0";
		}
		closeSession(session);
		return "1";
	}

	/**
	 * 通过ID来查找该实体类所在表中的记录
	 * 
	 * @param object
	 *            返回集合中的泛型
	 * @param Id
	 *            对象的ID
	 */
	public List<Object> getEntity(Object object, String Id) throws Exception {
		List<Object> list = new ArrayList<Object>();
		Object obj = hibernateTemplate.get(object.getClass(), Id);
		list.add(obj);
		return list;
	}

	/**
	 * 查询理论教学(手机版用)
	 */
	public List<ArticleBean> selectMobileTheoryTeaching() {
		final String sql = "select * from TB_ARTICLE where DEL_FLG = 0 and IARTICLEKIND IN(5, 6, 7, 8,9,10) order by DMAKETIME desc ";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(ArticleBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}

	/**
	 * 按文件的类型查找文件
	 */
	public List<FileBean> selectFileByFileType(int fileType) {
		final String sql = "select * from TB_FILE where FILE_TYPE = '"
				+ fileType + "' and DEL_FLG = 0 order by FILE_ID desc";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(FileBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}
}
