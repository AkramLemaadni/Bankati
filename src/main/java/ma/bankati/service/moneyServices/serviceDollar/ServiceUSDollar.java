package ma.bankati.service.moneyServices.serviceDollar;

import lombok.Getter;
import lombok.Setter;
import ma.bankati.dao.dataDao.IDao;
import ma.bankati.model.data.Devise;
import ma.bankati.model.data.MoneyData;
import ma.bankati.service.moneyServices.IMoneyService;

@Getter
@Setter
public class ServiceUSDollar implements IMoneyService {
    private IDao dao;

    public ServiceUSDollar() {}

    public ServiceUSDollar(IDao dao) {
        this.dao = dao;}

    @Override
    public MoneyData convertData(){

        var data =  dao.fetchData();

        var result =  data*1.08;
        return  new MoneyData(result, Devise.$);
    }
}
