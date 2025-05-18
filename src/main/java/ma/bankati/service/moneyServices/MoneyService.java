package ma.bankati.service.moneyServices;

import lombok.Getter;
import lombok.Setter;
import ma.bankati.dao.dataDao.IDao;
import ma.bankati.model.data.Devise;
import ma.bankati.model.data.MoneyData;

import java.time.LocalDate;

@Getter @Setter
public class MoneyService implements IMoneyService {

    private IDao dao;

    public MoneyService() { }

    public MoneyService(IDao dao) {
        this.dao = dao;
    }

    @Override
    public MoneyData convertData() {
        var data = dao.fetchData();
        // Default implementation returns the original data in Dirham
        return MoneyData.builder()
                .value(data)
                .devise(Devise.Dh)
                .creationDate(LocalDate.now())
                .build();
    }
} 