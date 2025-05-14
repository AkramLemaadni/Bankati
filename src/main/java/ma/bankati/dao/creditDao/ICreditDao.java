package ma.bankati.dao.creditDao;

import ma.bankati.dao.userDao.CrudDao;
import ma.bankati.model.credit.Credit;
import ma.bankati.model.credit.ECredit;
import java.util.List;

public interface ICreditDao extends CrudDao<Credit, Long> {
    List<Credit> findByUserId(Long userId);
    List<Credit> findByStatus(ECredit status);
}