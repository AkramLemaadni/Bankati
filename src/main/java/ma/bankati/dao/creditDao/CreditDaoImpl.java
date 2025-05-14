package ma.bankati.dao.creditDao;

import ma.bankati.model.credit.Credit;
import ma.bankati.model.credit.ECredit;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class CreditDaoImpl implements ICreditDao {
    private static final String FILE_PATH = "FileBase/credit.txt";
    private static final String DELIMITER = ";;";
    private Long currentId = 1L;

    @Override
    public Credit findById(Long id) {
        return findAll().stream()
                .filter(c -> c.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    @Override
    public List<Credit> findAll() {
        List<Credit> credits = new ArrayList<>();
        try {
            Path path = Paths.get(FILE_PATH);
            if (Files.exists(path)) {
                List<String> lines = Files.readAllLines(path);
                for (String line : lines) {
                    if (!line.trim().isEmpty()) {
                        credits.add(parseCredit(line));
                    }
                }
                currentId = credits.stream()
                        .mapToLong(Credit::getId)
                        .max()
                        .orElse(0L) + 1;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return credits;
    }

    @Override
    public Credit save(Credit credit) {
        List<Credit> credits = findAll();

        if (credit.getId() == null) {
            credit.setId(currentId++);
            credits.add(credit);
        } else {
            credits = credits.stream()
                    .map(c -> c.getId().equals(credit.getId()) ? credit : c)
                    .collect(Collectors.toList());
        }

        writeAll(credits);
        return credit;
    }

    @Override
    public void delete(Credit credit) {
        deleteById(credit.getId());
    }

    @Override
    public void deleteById(Long id) {
        List<Credit> credits = findAll().stream()
                .filter(c -> !c.getId().equals(id))
                .collect(Collectors.toList());
        writeAll(credits);
    }

    @Override
    public void update(Credit credit) {
        save(credit);
    }

    @Override
    public List<Credit> findByUserId(Long userId) {
        return findAll().stream()
                .filter(c -> c.getUserId().equals(userId))
                .collect(Collectors.toList());
    }

    @Override
    public List<Credit> findByStatus(ECredit status) {
        return findAll().stream()
                .filter(c -> c.getStatus() == status)
                .collect(Collectors.toList());
    }

    private Credit parseCredit(String line) {
        String[] parts = line.split(DELIMITER);
        Credit credit = new Credit();
        credit.setId(Long.parseLong(parts[0]));
        credit.setUserId(Long.parseLong(parts[1]));
        credit.setMontant(Double.parseDouble(parts[2]));
        credit.setDureeMois(Integer.parseInt(parts[3]));
        credit.setStatus(ECredit.valueOf(parts[4]));
        credit.setDateDemande(LocalDate.parse(parts[5]));
        return credit;
    }

    private String creditToString(Credit credit) {
        return String.join(DELIMITER,
                credit.getId().toString(),
                credit.getUserId().toString(),
                String.valueOf(credit.getMontant()),
                String.valueOf(credit.getDureeMois()),
                credit.getStatus().name(),
                credit.getDateDemande().toString());
    }

    private void writeAll(List<Credit> credits) {
        try {
            Path path = Paths.get(FILE_PATH);
            List<String> lines = credits.stream()
                    .map(this::creditToString)
                    .collect(Collectors.toList());

            if (!Files.exists(path.getParent())) {
                Files.createDirectories(path.getParent());
            }

            Files.write(path, lines, StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}