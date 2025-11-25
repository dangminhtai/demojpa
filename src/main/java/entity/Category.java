package entity;

import java.io.Serializable;
import java.util.List;

import javax.persistence.*;
import lombok.*;

@Entity
@Table(name = "categories")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Category implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CategoryId")
    private int categoryId;

    @Column(name = "Categoryname", columnDefinition = "nvarchar(200)")
    private String categoryname;

    @Column(name = "Categorycode", columnDefinition = "nvarchar(50)")
    private String categorycode;

    @Column(name = "Images", columnDefinition = "nvarchar(500)")
    private String images;

    @Column(name = "Status")
    private int status;

    @OneToMany(mappedBy = "category", fetch = FetchType.LAZY)
    private List<Video> videos;

    @ManyToOne
    @JoinColumn(name = "userid")
    private User user;
}
