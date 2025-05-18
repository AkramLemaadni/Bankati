package ma.bankati.model.credit;


import lombok.*;

import java.time.LocalDate;
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter
@Builder
public class Credit {

    private Long id;
    private Double montant;
    private Integer dureeMois;
    private ECredit status;
    private LocalDate dateDemande;
    private Long userId;
    
    // Transient field to store user information (not persisted in database)
    @Builder.Default
    private transient String userInfo = "";
}
