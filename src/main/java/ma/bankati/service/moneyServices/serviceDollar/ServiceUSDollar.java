package ma.bankati.service.moneyServices.serviceDollar;

import lombok.Getter;
import lombok.Setter;
import ma.bankati.dao.dataDao.IDao;
import ma.bankati.model.data.Devise;
import ma.bankati.model.data.MoneyData;
import ma.bankati.service.moneyServices.IMoneyService;

import java.time.LocalDate;

@Getter @Setter
public class ServiceUSDollar implements IMoneyService {

    private IDao dao;

    public ServiceUSDollar() { }

    public ServiceUSDollar(IDao dao) {
        this.dao = dao;
    }

    @Override
    public MoneyData convertData() {
        var data = dao.fetchData();
        var result = data * 0.098; // Convert from MAD to USD
        return MoneyData.builder()
                .value(result)
                .devise(Devise.Dollar)
                .creationDate(LocalDate.now())
                .build();
    }
}
