DROP DATABASE IF EXISTS bd_guia_filmes;
CREATE DATABASE bd_guia_filmes;
use bd_guia_filmes;

/*
    TABELAS PRINCIPAIS:
*/

CREATE TABLE tb_usuarios(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    username VARCHAR(20) NOT NULL,
    foto_perfil VARCHAR(500) DEFAULT "assets/img/users/default.svg",
    sobre VARCHAR(240),
    email VARCHAR(75) NOT NULL,   
    senha CHAR(32) NOT NULL
);

CREATE TABLE tb_filmes(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    url_cartaz TEXT NOT NULL,
    sinopse TEXT NOT NULL,
    nota_avaliacao DECIMAL(2, 1) DEFAULT 0.0,
    duracao_min INT(3) NOT NULL,
    num_curtidas INT DEFAULT 0,
    num_salvos INT DEFAULT 0,
    num_assistidos INT DEFAULT 0,
    ano_lancamento INT(4) NOT NULL,
    direcao VARCHAR(400) NOT NULL,
    roteiro VARCHAR(400) NOT NULL,
    distribuicao VARCHAR(100) NOT NULL,
    idioma VARCHAR(200) NOT NULL,
    pais VARCHAR(30) NOT NULL,
    elenco VARCHAR(500) NOT NULL,
    nome_original VARCHAR(100)
);

CREATE TABLE tb_generos(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL
);


CREATE TABLE tb_plataformas(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    url_icone TEXT NOT NULL,
    url_link TEXT NOT NULL
);    

CREATE TABLE tb_resenhas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_filme INT NOT NULL,
    id_usuario INT NOT NULL,
    titulo VARCHAR(100) DEFAULT "",
    descricao TEXT NOT NULL,
    nota_avaliacao DECIMAL(2, 1) DEFAULT 0.0,
    data_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES tb_usuarios (id),
    FOREIGN KEY (id_filme) REFERENCES tb_filmes (id)
);


/*/================================================/*/
/* TABELAS AUXILIARES (N-N) */

CREATE TABLE tb_generos_filmes(
    id_genero INT NOT NULL,
    id_filme INT NOT NULL,
    FOREIGN KEY (id_genero) REFERENCES tb_generos (id),
    FOREIGN KEY (id_filme) REFERENCES tb_filmes (id)
);

CREATE TABLE tb_plataformas_filmes(
    id_plataforma INT NOT NULL,
    id_filme INT NOT NULL,
    FOREIGN KEY (id_plataforma) REFERENCES tb_plataformas (id), 
    FOREIGN KEY (id_filme) REFERENCES tb_filmes (id)
);

CREATE TABLE tb_filmes_assistidos_usuario(
    id_filme INT NOT NULL,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_filme) REFERENCES tb_filmes (id),
    FOREIGN KEY (id_usuario) REFERENCES tb_usuarios (id)
);

CREATE TABLE tb_filmes_curtidos_usuario(
    id_filme INT NOT NULL,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_filme) REFERENCES tb_filmes (id),
    FOREIGN KEY (id_usuario) REFERENCES tb_usuarios (id)
);

CREATE TABLE tb_filmes_salvos_usuario(
    id_filme INT NOT NULL,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_filme) REFERENCES tb_filmes (id),
    FOREIGN KEY (id_usuario) REFERENCES tb_usuarios (id)
);

CREATE TABLE tb_usuarios_seguidores (
    id_usuario INT NOT NULL,
    id_seguidor INT NOT NULL,
    FOREIGN KEY(id_usuario) REFERENCES tb_usuarios(id),
    FOREIGN KEY(id_seguidor) REFERENCES tb_usuarios(id)
);


/*/================================================/*/
/* INSER????O DE DADOS */

INSERT INTO tb_filmes (nome, url_cartaz, sinopse, duracao_min, ano_lancamento, direcao, roteiro, distribuicao, idioma, pais, nome_original, elenco)
VALUES 
    ("Sociedade dos Poetas Mortos", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcYujNBQq53Q8zvISFhnguM42cFndgo-8UQso2ZMZREnEhhMQW", "O novo professor de Ingl??s John Keating ?? introduzido a uma escola preparat??ria de meninos que ?? conhecida por suas antigas tradi????es e alto padr??o. Ele usa m??todos pouco ortodoxos para atingir seus alunos, que enfrentam enormes press??es de seus pais e da escola. Com a ajuda de Keating, os alunos Neil Perry, Todd Anderson e outros aprendem como n??o serem t??o t??midos, seguir seus sonhos e aproveitar cada dia.", 128, 1989, "Peter Weir", "Tom Schulman", "Disney", "Ingl??s", "Estados Unidos", "Dead Poets Society", "Robin Williams;Ethan Hawke;Robert Sean;Josh Charles"),
    ("Antes do Amanhecer", "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcRytXtKVFseDVfEqbi-SFX_OXjed_SzDJWd0qQ9MPdclk-YcKc8", "Jesse, um jovem americano, e Celine, uma linda francesa, se conhecem no trem para Paris, e come??am uma conversa que os leva a fazer uma escala em Viena e ficar um pouco mais juntos, sem imaginar o que o destino os reserva.", 105, 1995, "Richard Linklater", "Richard Linklater, Kim Krizan", "Columbia Pictures", "Ingl??s", "Estados Unidos e ??ustria", "Before Sunrise", "Ethan Hawke;Julie Delpy;Hanno Poschl;Hans Weingartner"),
    ("Viva: A Vida ?? Uma Festa", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLlC1BU-d_49KZvZrLQ6vhp_dsWObCyp9a7UuJe0-8tpQcJ3fM", "Apesar da proibi????o da m??sica por gera????es de sua fam??lia, o jovem Miguel sonha em se tornar um m??sico talentoso como seu ??dolo Ernesto de la Cruz. Desesperado para provar seu talento, Miguel se encontra na deslumbrante e colorida Terra dos Mortos. Depois de conhecer um charmoso malandro chamado H??ctor, os dois novos amigos embarcam em uma jornada extraordin??ria para desvendar a verdadeira hist??ria por tr??s da hist??ria da fam??lia de Miguel.", 105, 2017, "Adrian Molina, Lee Unkrich", "Adrian Molina, Lee Unkrich, Matthew Aldrich, Jason Katz", "Disney", "Ingl??s", "Estados Unidos", "Coco", "Arthur Salerno;Leando Luna;Nando Pradho;Adriana Quadros"),
    ("Uma Noite de Crime", "https://br.web.img3.acsta.net/pictures/210/335/21033500_20130830193413918.jpg", "The Purge ?? uma franquia americana de filmes de terror e a????o, composta por cinco filmes e uma s??rie de televis??o. A franquia se passa numa vers??o dist??pica dos Estados Unidos onde, uma vez por ano, durante um per??odo de 12 horas, todo crime, incluindo at?? mesmo estupro e homic??dio, ?? legalizado.", 88, 2013, "James DeMonaco", "James DeMonaco", "Universal Pictures", "Ingl??s", "Estados Unidos", "The Purge", "Ethan Hawke;Lena Headey;Max Burkholder;Adelaide Kane"),
    ("Em Busca da Perfei????o", "https://i.pinimg.com/originals/e3/ae/19/e3ae19905686795e350cbb54ff4c99ea.jpg", "Andrew sonha em ser o melhor baterista de sua gera????o. Ele chama a aten????o do impiedoso mestre do jazz Terence Fletcher, que ultrapassa os limites e transforma seu sonho em uma obsess??o, colocando em risco a sa??de f??sica e mental do jovem m??sico.", 107, 2014, "Damien Chazelle", "Damien Chazelle", "Sony Pictures Classics", "Ingl??s", "Estados Unidos", "Whiplash", "Miles Teller;J.K Simmons;Paul Reiser;Melissa Benoist"),
    ("O Sexto Sentido", "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSm1bD7Hdfo2lFPc4GdhCWa0moWg5jkL_rnnD8eIJz0BmaSCe2V", "Um garoto v?? o esp??rito de pessoas mortas ?? sua volta. Um dia, ele conta o segredo ao psic??logo Malcolm Crowe, que tenta ajud??-lo a descobrir o que est?? por tr??s dos dist??rbios. A pesquisa de Crowe sobre os poderes do garoto causa consequ??ncias inesperadas a ambos.", 107, 1999, "M. Night Shyamalan", "M. Night Shyamalan", "Buena Vista Pictures Distribution", "Ingl??s", "Estados Unidos", "The Sixth Sense", "Bruce Willis;Haley Joel Osment;Toni Collete;Olivia Williams"),
    ("A Outra Face", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4yxlPR0kQVjAP_xXjOYdtdrxTEsvNNq1utBORBZqQUo5CBtZz", "Agente do FBI troca de rosto com um terrorista para vingar a morte do filho, mas tudo se transforma em um grande pesadelo e ele precisa lutar pela sua vida e tamb??m de sua fam??lia.", 138, 1997, "John Woo", "Mike Werb e Michael Colleary", "Paramount Pictures (Am??rica do Norte) e Buena Vista International", "Ingl??s", "Estados Unidos", "Face Off", "John Travolta;Nicolas Cage;Joan Allen;Alessandro Nivola"),
    ("O Show de Truman", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOcA2mFPvtwJaYBUmFebJ0g6DUyrsl912CcPkAFhnkkj2Dt-d6", "Truman Burbank ?? um pacato vendedor de seguros que leva uma vida simples com sua esposa Meryl Burbank. Por??m, algumas coisas ao seu redor fazem com que ele passe a estranhar sua cidade, seus supostos amigos e at?? sua mulher. Ap??s conhecer a misteriosa Lauren, ele fica intrigado e acaba descobrindo que toda sua vida foi monitorada por c??meras e transmitida em rede nacional.", 103, 1998, "Peter Weir", "Andrew Niccol", "Paramount Pictures", "Ingl??s", "Estado Unidos", "The Thuman Show", "Jim Carrey;Laura Linney;Ed Harris;Noah Emmerich;Natascha McElhone"),
    ("Jogos Mortais", "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQ_bHH1GHmNAry7yF3QASbvbIb-pV6xwmnad02t0HWw2CHO5-mS", "Dois homens acordam acorrentados em um banheiro como prisioneiros de um assassino em s??rie que leva suas v??timas a situa????es lim??trofes em um jogo macabro. Para sobreviver, eles ter??o de desvendar juntos as pe??as desse quebra-cabe??as doentio.", 103, 2004, "James Wan", "Leigh Whannell", "Lions Gate Films e Paris Filmes (Brasil)", "Ingl??s", "Estados Unidos", "The Thuman Show", "Tobin Beel;Cary Elwes;Leigh Whannell;Shawnee Smith;Danny Glover;Michael Emerson"),
    ("Truque de Mestre", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrBOuSm7oyIe_011NtkMuNHwxtZNFQIeqZLtMHjM3K33dEOgOe", "Um grupo de ilusionistas encanta o p??blico com suas m??gicas e tamb??m rouba bancos em outro continente, distribuindo a quantia para os pr??prios espectadores. O agente do FBI Dylan Hobbs est?? determinado a captur??-los e conta com a ajuda de Alma Vargas, uma detetive da Interpol, e tamb??m de Thaddeus Bradley, um veterano desmistificador de m??gicos que insiste que os assaltos s??o realizados a partir de disfarces e jogos envolvendo v??deos.", 115, 2013, "Louis Leterrier", "Ed Solomon e Boaz Yakin", "Lionsgate", "Ingl??s", "Estados Unidos", "Insaisissables", "Jesse Eisenberg;Mark Ruffalo;Woody Harrelson;Morgan Freeman"),
    ("Truque de Mestre 2", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLhkR1Ujnjew3254Vmxtg8fwKntloYLedwswqCaMBoS-oe91bR", "Ap??s enganarem o FBI, os cavaleiros Daniel Atlas, Merritt McKinney e Jack Wilder est??o foragidos. Eles seguem as ordens de Dylan Rhodes, que segue trabalhando no FBI de forma a impedir os avan??os na procura dos pr??prios cavaleiros. Paralelamente, o grupo planeja seu novo ato: desmascarar um jovem g??nio da inform??tica, cujo novo lan??amento coleta dados pessoais dos usu??rios.", 130, 2016, "Jon M. Chu", "Ed Solomon", "Summit Entertainment", "Ingl??s", "Estado Unidos", "Insaisissables 2", "Jesse Eisenberg;Mark Ruffalo;Woody Harrelson;Lizzy Caplan"),
    ("Velozes e Furiosos 5: Opera????o Rio", "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTo3ITeQq2pZsUEsuo30L9sTU3bCnRR4qN5l_4CVkYGd-VskiP8", "Desde que o ex-policial Brian O'Conner e Mia Toretto libertaram Dom da pris??o, eles viajam pelo mundo para fugir das autoridades. No Rio de Janeiro, eles s??o obrigados a fazer um ??ltimo trabalho antes de ganhar sua liberdade definitiva. Brian e Dom montam uma equipe de elite de pilotos de carro para executar a tarefa, mas precisam enfrentar um empres??rio corrupto e tamb??m um obstinado agente federal norte-americano.", 130, 2011, "Justin Lin", "chris Morgan", "Universal Pictures", "Ingl??s", "Estados Unidos", "Fast & Furious 5: Rio Heis", "Vin Diesel;Paul Walker;Gal Gadot;Dwayne Johnson"),
    ("Pantera Negra", "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQarmjVytz3ISRKJNwmxG7o-r4sWWN5VxbPp9qJauK4VvGrKu36", "Em Pantera Negra, ap??s a morte do rei T'Chaka (John Kani), o pr??ncipe T'Challa (Chadwick Boseman) retorna a Wakanda para a cerim??nia de coroa????o. Nela s??o reunidas as cinco tribos que comp??em o reino, sendo que uma delas, os Jabari, n??o apoia o atual governo. T'Challa logo recebe o apoio de Okoye (Danai Gurira), a chefe da guarda de Wakanda, da irm?? Shuri (Letitia Wright), que coordena a ??rea tecnol??gica do reino, e tamb??m de Nakia (Lupita Nyong'o), a grande paix??o do atual Pantera Negra, que n??o quer se tornar rainha. Juntos, eles est??o ?? procura de Ulysses Klaue (Andy Serkis), que roubou de Wakanda um punhado de vibranium, alguns anos atr??s.", 135, 2018, "Ryan Coogler", "Stan Lee", "Disney", "Ingl??s", "Estados Unidos", "Black Panther", "Chadwick Boseman;Lupita Nyong'o;Michael B. Jordan;Danai Gurira"),
    ("A Grande Muralha", "https://br.web.img3.acsta.net/pictures/16/08/01/14/48/338063.jpg", "Um grupo de soldados brit??nicos est?? lutando na China e se depara com o in??cio das constru????es da Grande Muralha. Eles percebem que o intuito n??o ?? apenas proteger a popula????o do inimigo mongol e que a constru????o esconde na verdade um grande segredo.", 103, 2017, "Zhang Yimou", "Carlo Bernard e Doug Miro", " 	Universal Pictures e China Film Group", "Ingl??s", "Estados Unidos", "The Great Wall", "Matt Damon;Jing Tian;Willem Dafoe;Pedro Pascal"),
    ("Piratas do Caribe: A Maldi????o do P??rola Negra", "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTvMYX13i4GzSEzDGhNKaLu-eu7zRcScx_BjTDK2gvvwRkRcqWz", "O pirata Jack Sparrow tem seu navio saqueado e roubado pelo capit??o Barbossa e sua tripula????o. Com o navio de Sparrow, Barbossa invade a cidade de Port Royal, levando consigo Elizabeth Swann, filha do governador. Para recuperar sua embarca????o, Sparrow recebe a ajuda de Will Turner, um grande amigo de Elizabeth. Eles desbravam os mares em dire????o ?? misteriosa Ilha da Morte, tentando impedir que os piratas-esqueleto derramem o sangue de Elizabeth para desfazer a maldi????o que os assola.", 153, 2003, "Gore Verbinski", "Ted Elliott, Terry Rossio, Stuart Beattie e Jay Wolpert", "Buena Vista Pictures", "Ingl??s", "Estados Unidos", "Pirates of the Caribbean: The Curse of the Black Pearl", "Johnny Depp;Keira Knightley;Orlando Bloom;Geoffrey Rush"),
    ("Soul", "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcRmL0LHrUY5XZWfDmHV6-WbTQH6J2FMlZ_JqK7E8oPXcqYgVEE-", "Joe ?? um professor de m??sica do ensino m??dio apaixonado por jazz, cuja vida n??o foi como ele esperava. Quando ele viaja a uma outra realidade para ajudar outra pessoa a encontrar sua paix??o, ele descobre o verdadeiro sentido da vida.", 100, 2020, "Pete Docter, Kemp Powers", "Pete Docter, Kemp Powers", "Disney", "Ingl??s", "Estados Unidos", NULL, "Jamie Foxx;Tina Fey;Graham Norton"),
    ("A Nova Onda do Imperador", "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQCsKA1RQh59O3CUu_h7Q3UBqG90RfN7MfgOxtAnTQwCNQN-0ag", "O jovem e arrogante Imperador Kuzco ?? transformado em uma lhama por sua poderosa mentora chamada Yzma. Perdido na floresta, a ??nica chance de Kuzco recuperar seu trono ?? com a ajuda de Pacha, um humilde campon??s. Juntos, eles precisam enfrentar a bruxa Yzma antes de concluir sua jornada.", 78, 2000, "Mark Dindal", "Stephen J. Anderson, Don Hall", "Buena Vista Pictures", "Ingl??s", "Estados Unidos", "The Emperor's New Groove", "David Spade;John Goodman;Patrick Warburton;Eartha Kitt"),
    ("As Vantagens de Ser Invis??vel", "https://br.web.img3.acsta.net/medias/nmedia/18/90/78/52/20295598.jpg", "Um jovem t??mido se esconde em seu pr??prio mundo at?? conhecer dois irm??os que o ajudam a viver novas experi??ncias. Embora esteja feliz nessa nova fase, ele n??o esquece as tristezas do passado, que t??m origem em uma chocante revela????o.", 105, 2012, "Stephen Chbosky", "Stephen Chbosky, Stephen Chbosky", "Summit Entertainment", "Ingl??s", "Estados Unidos", "The Perks of Being a Wallflower", "Logan Lerman;Emma Watson;Ezra Miller;Erin Wilhelmi"),
    ("O Castelo Animado", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKZ7FR5KMc8sY9rMJ520kSC1C_o6IxYl-vs5vKzglEhcEA755p", "Uma bruxa lan??a uma terr??vel maldi????o sobre a jovem Sophie transformando-a numa velha de 90 anos. Desesperada, ela embarca numa odisseia em busca do Castelo Andante, onde reside um misterioso feiticeiro que poder?? ajud??-la a reverter o feiti??o.", 99, 2004, "Hayao Miyazaki", "Diana Wynne Jones, Hayao Miyazaki", "Toho", "Japon??s", "Jap??o", "Hauru no Ugoku Shiro", "Chieko Baish??;Takuya Kimura;Ry??nosuke Kamiki;Mitsunori Isaki"),
    ("O Homem de Palha", "https://blogdokira250242846.files.wordpress.com/2020/08/homem.jpg", "Uma jovem desaparece misteriosamente. Para investigar o desaparecimento, o Sargento Howie viaja para uma remota ilha escocesa onde conhece o esquisito Lord Summerisle, um l??der religioso da pequena comunidade que realiza estranhos rituais pag??os.", 92, 1973, "Robin Hardy", "Anthony Shaffer", "British Lion Films", "Ingl??s", "Reino Unido", "The Wicker Man", "Edward Woodward;Diane Cilento;Ingrid Pitt;Chrisstopher Lee");


INSERT INTO tb_plataformas (nome, url_icone, url_link)
VALUES 
    ("Amazon Prime", "assets/img/icons/amazon-icon.svg", "https://www.primevideo.com/"),
    ("Apple TV+", "assets/img/icons/apple-icon.svg", "https://www.apple.com/br/apple-tv-plus/"),
    ("Disney +", "assets/img/icons/disney-icon.svg", "https://www.disneyplus.com/"),
    ("HBO Go", "assets/img/icons/hbo-icon.svg", "https://www.hbomax.com/"),
    ("Netflix", "assets/img/icons/netflix-icon.svg", "https://www.netflix.com"),
    ("Youtube", "assets/img/icons/yt-icon.svg", "https://www.youtube.com/feed/storefront"),
    ("Star +", "assets/img/icons/star-plus-icon.svg", "https://www.starplus.com");


-- Registro dos g??neros
INSERT INTO tb_generos(nome) 
VALUES 
    ("A????o"), ("Com??dia"), ("Drama"), ("Document??rio"), ("Infantil"), ("Fantasia"), ("Terror"), ("Romance"), ("Fic????o cient??fica"), ("Suspense"), ("Anima????o"), ("Musical"), ("Aventura");


-- Rela????o entre generos e filmes
INSERT INTO tb_generos_filmes(id_filme, id_genero)
VALUES
    -- Sociedade dos poetas mortos
    (1, 3),

    -- Antes de Amanhecer
    (2, 3), (2, 8),

    -- Viva
    (3, 5), (3, 11), (3, 12), (3, 13),
    
    -- Uma noite de crime
    (4, 3), (4, 7), (4, 10),

    -- Whiplash
    (5, 3), (5, 12),

    -- O sexto sentido
    (6, 7), (6, 10), (6, 3),

    -- A outra face
    (7, 1), (7, 9), (7, 13), (7, 10),

    -- O show de truman
    (8, 2), (8, 3), (8, 9), 

    -- Jogos mortais
    (9, 7), (9, 10),

    -- Truque de mestre
    (10, 1), (10, 10),

    -- Truque de mestre 2
    (11, 1), (11, 10), (11, 13),

    -- Velozes e Furiosos 5: Opera????o Rio
    (12, 1), (12, 10),

    -- Pantera Negra
    (13, 1), (13, 9), (13, 13),

    -- A Grande Muralha
    (14, 1), (14, 13), (14, 10),
    
    -- Piratas do Caribe: A Maldi????o do P??rola Negra
    (15, 1), (15, 13), (15, 2),

    -- Soul
    (16, 3), (16, 5), (16, 11), (16, 12),

    -- A nova onda do imperador
    (17, 2), (17, 5), (17, 13), (17, 11), (17, 12),

    -- As vantagens de ser invis??vel
    (18, 3), (18, 8),

    -- O castelo animado
    (19, 11), (19, 3), (19, 6), (19, 8), (19, 13),

    -- O homem de palha
    (20, 7), (20, 6), (20, 10);


INSERT INTO tb_plataformas_filmes (id_plataforma, id_filme)
VALUES 
    -- Sociedade dos poetas mortos
    (7, 1),

    -- Antes de Amanhecer
    (4, 2), 

    -- Viva
    (3, 3),

    -- Uma noite de crime
    (1, 4), (5, 4), (6, 4), (7, 4),

    -- Whiplash
    (5, 5), (6, 5),

    -- O sexto sentido
    (7, 6),

    -- A outra face
    (7, 7),

    -- O show de truman
    (1, 8), (6, 8), (7, 8),

    -- Jogos mortais
    (4 , 9), (7, 9),

    -- Truque de mestre
    (4, 10), (5, 10), (7, 10),

    -- Truque de mestre 2
    (4, 11), (5, 11),

    -- Velozes e furiosos 5
    (1, 12), (7, 12),

    -- Pantera negra
    (3, 13),

    -- A grande Muralha
    (1, 14), (5, 14),

    -- Piratas do Caribe
    (3, 15),

    -- Soul
    (3 , 16), 

    -- A nova onda do imperador
    (3, 17),

    -- As vantagens de ser invis??vel
    (1, 18), (2, 18), (4, 18), (5, 18), (6, 18),

    -- O castelo animado
    (5, 19);