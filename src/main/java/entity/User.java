package entity;

import javax.persistence.*;
import lombok.*;

@Entity
@Table(name = "users")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "username", columnDefinition = "nvarchar(200)")
    private String username;

    @Column(name = "password", columnDefinition = "nvarchar(500)")
    private String password;

    @Column(name = "email", columnDefinition = "nvarchar(200)")
    private String email;

    @Column(name = "fullname", columnDefinition = "nvarchar(200)")
    private String fullname;
    
    @Column(name = "phone", columnDefinition = "nvarchar(15)")
    private String phone;
    
    @Column(name = "images", columnDefinition = "nvarchar(500)")
    private String images;
    
    @Column(name = "admin")
    private boolean admin;
    
    @Column(name = "active")
    private boolean active;
}
