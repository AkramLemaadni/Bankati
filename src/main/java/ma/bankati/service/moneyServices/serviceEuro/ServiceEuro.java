package ma.bankati.service.moneyServices.serviceEuro;

import lombok.Getter;
import lombok.Setter;
import ma.bankati.dao.dataDao.IDao;
import ma.bankati.model.data.Devise;
import ma.bankati.model.data.MoneyData;
import ma.bankati.service.moneyServices.IMoneyService;

import java.time.LocalDate;

@Getter @Setter
public class ServiceEuro implements IMoneyService {

    private IDao dao;

    public ServiceEuro() { }

    public ServiceEuro(IDao dao) {
        this.dao = dao;
    }

    @Override
    public MoneyData convertData() {
        var data = dao.fetchData();
        var result = data * 0.091; // Convert from MAD to EUR
        return MoneyData.builder()
                .value(result)
                .devise(Devise.Euro)
                .creationDate(LocalDate.now())
                .build();
    }
} 