package ma.bankati.model.data;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MoneyData {
    private Long id;
    private Double value;
    private Devise devise;
    private LocalDate creationDate;
}
