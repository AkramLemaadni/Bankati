package ma.bankati.dao.dataDao.memoryDb;

import ma.bankati.dao.dataDao.IDao;


public class DataDao implements IDao {

    public DataDao() { }

    @Override
    public double fetchData() {return db();}

    static double db(){
        double solde = 500.0;

        return solde;
    }
}
