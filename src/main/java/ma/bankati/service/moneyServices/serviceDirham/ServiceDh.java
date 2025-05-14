package ma.bankati.service.moneyServices.serviceDirham;

import lombok.Getter;
import lombok.Setter;
import ma.bankati.dao.dataDao.IDao;
import ma.bankati.model.data.Devise;
import ma.bankati.model.data.MoneyData;
import ma.bankati.service.moneyServices.IMoneyService;


@Getter @Setter
public class ServiceDh   implements IMoneyService {

   private IDao dao;

    public ServiceDh() { }

    public ServiceDh(IDao dao) {
        this.dao = dao;
    }

    @Override
   public MoneyData convertData(){

       var data =  dao.fetchData();

        var result =  data*10.0;
        return  new MoneyData(result, Devise.Dh);
    }


}
