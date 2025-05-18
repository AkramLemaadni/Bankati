package ma.bankati.model.users;

import java.time.LocalDate;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
@Setter
@ToString
public class User {

    private Long id;
    private String firstName;
    private String lastName;
    private String username;
    private String password;
    private ERole  role;
    private LocalDate creationDate = LocalDate.now();
}
