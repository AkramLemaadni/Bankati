package ma.bankati.service.moneyServices.servicePound;

import lombok.Getter;
import lombok.Setter;
import ma.bankati.dao.dataDao.IDao;
import ma.bankati.model.data.Devise;
import ma.bankati.model.data.MoneyData;
import ma.bankati.service.moneyServices.IMoneyService;

import java.time.LocalDate;

@Getter @Setter
public class ServicePound implements IMoneyService {
    private IDao dao;

    public ServicePound() {}

    public ServicePound(IDao dao) {
        this.dao = dao; }

    @Override
    public MoneyData convertData(){
        var data =  dao.fetchData();
        var result =  data * 0.078;
        return MoneyData.builder()
                .value(result)
                .devise(Devise.Pound)
                .creationDate(LocalDate.now())
                .build();
    }
}
