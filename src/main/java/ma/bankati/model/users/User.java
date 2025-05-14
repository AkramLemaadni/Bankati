package ma.bankati.model.users;

import java.time.LocalDate;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data  @AllArgsConstructor @NoArgsConstructor @Builder
public class User {

    private Long id;
    private String firstName;
    private String lastName;
    private String username;
    private String password;
    private ERole  role;
    private LocalDate creationDate = LocalDate.now();


    public String toString(){
        return "[" + role.toString()+ "] " + firstName + " " + lastName;
    }
    public String getUserInfos(){
        return "[ login : " + username + ", password : " + password + "]";
    }

}
