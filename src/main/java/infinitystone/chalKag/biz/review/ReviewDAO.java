package infinitystone.chalKag.biz.review;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository("reviewDAO")
public class ReviewDAO {

  @Autowired
  private JdbcTemplate jdbcTemplate;

  private static final String SELECTALL = "SELECT REVIEW.REVIEW_id " +
      "REVIEW.MEMBER_id, " +
      "MEMBER1.MEMBER_nickname AS MEMBER_nickname, " +
      "REVIEW.REVIEW_partner, " +
      "MEMBER2.MEMBER_nickname AS REVIEW_partnernickname, " +
      "REVIEW.REVIEW_date, " +
      "REVIEW.REVIEW_score, " +
      "REVIEW.REVIEW_content " +
      "FROM REVIEW " +
      "INNER JOIN MEMBER MEMBER1 ON REVIEW.MEMBER_id = MEMBER1.MEMBER_id " +
      "INNER JOIN MEMBER MEMBER2 ON REVIEW.REVIEW_partner = MEMBER2.MEMBER_id " +
      "WHERE REVIEW.REVIEW_partner = ?";

  private static final String SELECTONE = "SELECT REVIEW_id, " +
      "(SELECT PROFILEIMG_name " +
      "FROM PROFILEIMG " +
      "WHERE PROFILEIMG.MEMBER_id = REVIEW.MEMBER_id " +
      "ORDER BY PROFILEIMG_id DESC " +
      "LIMIT 1) AS PROFILEIMG_name, " +
      "REVIEW.MEMBER_id, " +
      "MEMBER.MEMBER_nickname, " +
      "REVIEW_partner, " +
      "REVIEW_date, " +
      "REVIEW_score, " +
      "REVIEW_content " +
      "FROM REVIEW " +
      "INNER JOIN MEMBER ON REVIEW.MEMBER_id = MEMBER.MEMBER_id " +
      "ORDER BY REVIEW_id DESC " +
      "LIMIT 1";

  private static final String INSERT = "INSERT INTO REVIEW (MEMBER_id, " +
      "REVIEW_partner, " +
      "REVIEW_score, " +
      "REVIEW_content) " +
      "VALUES (?, ?, ?, ?)";

  private static final String UPDATE = "";

  private static final String DELETE = "DELETE REVIEW" +
      "FROM REVIEW" +
      "WHERE REVIEW_id = ?";

  public List<ReviewDTO> selectAll(ReviewDTO reviewDTO) {
    return (List<ReviewDTO>) jdbcTemplate.queryForObject(SELECTALL, new ReviewRowMapper());
  }

  public ReviewDTO selectOne(ReviewDTO reviewDTO) {
    System.out.println("ReivewDAO In로그 = [" + reviewDTO + "]");
    return jdbcTemplate.queryForObject(SELECTONE, new ReviewSelectOneRowMapper());
  }

  public boolean insert(ReviewDTO reviewDTO) {
    System.out.println("ReviewDAO(insert) In로그 = [" + reviewDTO + "]");
    if (jdbcTemplate.update(INSERT, reviewDTO.getMemberId(), reviewDTO.getReviewPartner(), reviewDTO.getReviewScore(), reviewDTO.getReviewContent()) <= 0) {
      return false;
    }
    return true;
  }

  public boolean update(ReviewDTO reviewDTO) {
    return false;
  }

  public boolean delete(ReviewDTO reviewDTO) {
    if (jdbcTemplate.update(DELETE) <= 0) {
      return false;
    }
    return true;
  }

}

class ReviewRowMapper implements RowMapper<ReviewDTO> {
  @Override
  public ReviewDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
    ReviewDTO reviewDTO = new ReviewDTO();
    reviewDTO.setReviewId(rs.getString("REVIEW_id"));
    reviewDTO.setMemberId(rs.getString("MEMBER_id"));
    reviewDTO.setMemberNickname(rs.getString("MEMBER_nickname"));
    reviewDTO.setReviewPartner(rs.getString("REVIEW_partner"));
    reviewDTO.setReviewPartnerNickname(rs.getString("REVIEW_partnernickname"));
    reviewDTO.setReviewDate(rs.getString("REVIEW_date"));
    reviewDTO.setReviewScore(rs.getString("REVIEW_score"));
    reviewDTO.setReviewContent(rs.getString("REVIEW_content"));
    return reviewDTO;
  }
}

class ReviewSelectOneRowMapper implements RowMapper<ReviewDTO> {
  @Override
  public ReviewDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
    ReviewDTO reviewDTO = new ReviewDTO();
    reviewDTO.setReviewId(rs.getString("REVIEW_id"));
    reviewDTO.setProfileImgName(rs.getString("PROFILEIMG_name"));
    reviewDTO.setMemberId(rs.getString("REVIEW.MEMBER_id"));
    reviewDTO.setMemberNickname(rs.getString("MEMBER.MEMBER_nickname"));
    reviewDTO.setReviewPartner(rs.getString("REVIEW_partner"));
    reviewDTO.setReviewDate(rs.getString("REVIEW_date"));
    reviewDTO.setReviewScore(rs.getString("REVIEW_score"));
    reviewDTO.setReviewContent(rs.getString("REVIEW_content"));
    return reviewDTO;
  }
}
