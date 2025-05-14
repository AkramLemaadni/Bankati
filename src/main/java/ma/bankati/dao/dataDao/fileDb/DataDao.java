package ma.bankati.dao.dataDao.fileDb;

import ma.bankati.dao.dataDao.IDao;

import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class DataDao implements IDao {


    public DataDao() {

    }


    @Override
    public double fetchData() {


        try {

            URL ressource = getClass().getClassLoader().getResource("FileBase/compte.txt");
            Path chemin = Paths.get(ressource.toURI());

            var r = Files.readAllLines(chemin)
                    .stream()
                    .skip(1)
                    .findFirst()
                    .get();

            return Double.parseDouble(r);

        } catch (Exception e) {
            return 0.0;
        }

    }
}
