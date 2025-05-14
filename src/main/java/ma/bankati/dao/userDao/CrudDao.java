package ma.bankati.dao.userDao;

import java.util.List;

public interface CrudDao <T, ID>
{
    T findById(ID identity);
    List<T> findAll();
    T save(T newElement);
    void delete(T element);
    void deleteById(ID identity);
    void update(T newValuesElement);
}
