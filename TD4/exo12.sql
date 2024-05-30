-- Create COMPETITION table
CREATE TABLE COMPETITION (
    CODE_COMP VARCHAR2(10) PRIMARY KEY,
    NOM_COMPETITION VARCHAR2(100)
);

-- Create PARTICIPANT table
CREATE TABLE PARTICIPANT (
    NO_PART NUMBER PRIMARY KEY,
    NOM_PART VARCHAR2(100),
    DATENAISSANCE DATE,
    ADRESSE VARCHAR2(200),
    EMAIL VARCHAR2(100)
);

-- Create SCORE table
CREATE TABLE SCORE(
    NO_PAR NUMBER,
    CODE_COMP VARCHAR2(10),
    NO_JUGE NUMBER,
    NOTE NUMBER,
    FOREIGN KEY (NO_PAR) REFERENCES PARTICIPANT(NO_PART),
    FOREIGN KEY (CODE_COMP) REFERENCES COMPETITION(CODE_COMP)
);

-- Insert sample data
INSERT INTO COMPETITION (CODE_COMP, NOM_COMPETITION) VALUES ('CMP001', 'Competition A');
INSERT INTO COMPETITION (CODE_COMP, NOM_COMPETITION) VALUES ('CMP002', 'Competition B');

INSERT INTO PARTICIPANT (NO_PART, NOM_PART, DATENAISSANCE, ADRESSE, EMAIL) VALUES (1, 'Participant 1', DATE '1990-01-01', 'Address 1', 'email1@example.com');
INSERT INTO PARTICIPANT (NO_PART, NOM_PART, DATENAISSANCE, ADRESSE, EMAIL) VALUES (2, 'Participant 2', DATE '1992-02-02', 'Address 2', 'email2@example.com');

INSERT INTO SCORE (NO_PAR, CODE_COMP, NO_JUGE, NOTE) VALUES (1, 'CMP001', 1, 8.5);
INSERT INTO SCORE (NO_PAR, CODE_COMP, NO_JUGE, NOTE) VALUES (1, 'CMP001', 2, 9.0);
INSERT INTO SCORE (NO_PAR, CODE_COMP, NO_JUGE, NOTE) VALUES (2, 'CMP001', 1, 7.5);
INSERT INTO SCORE (NO_PAR, CODE_COMP, NO_JUGE, NOTE) VALUES (2, 'CMP001', 2, 8.0);

COMMIT;

SET SERVEROUTPUT ON;
-- Exercice 12.
DECLARE
    v_nom_competition VARCHAR2(100);
    
    CURSOR crsr_participants (p_nom_competition VARCHAR2) IS
        SELECT p.NO_PART, p.NOM_PART, p.DATENAISSANCE, p.ADRESSE, p.EMAIL, SUM(s.NOTE) AS TOTAL_SCORE
        FROM PARTICIPANT p
        JOIN SCORE s 
        ON p.NO_PART = s.NO_PAR
        WHERE s.CODE_COMP IN (
            SELECT CODE_COMP
            FROM COMPETITION
            WHERE NOM_COMPETITION = p_nom_competition
        )
        GROUP BY p.NO_PART, p.NOM_PART, p.DATENAISSANCE, p.ADRESSE, p.EMAIL;
        
    v_no_part PARTICIPANT.NO_PART%TYPE;
    v_nom_part PARTICIPANT.NOM_PART%TYPE;
    v_date_naissance_part PARTICIPANT.DATENAISSANCE%TYPE;
    v_adresse_part PARTICIPANT.ADRESSE%TYPE;
    v_email_part PARTICIPANT.EMAIL%TYPE;
    
    v_total_score NUMBER;
BEGIN
    -- Lire le nom de la compétition depuis la console
    v_nom_competition := '&v_nom_competition';

    -- Ouvrir le curseur
    OPEN crsr_participants(v_nom_competition);

    -- Récupérer les participants et leurs scores totaux
    LOOP
        FETCH crsr_participants 
        INTO v_no_part, v_nom_part,  v_date_naissance_part, v_adresse_part, v_email_part, v_total_score;
        EXIT WHEN crsr_participants%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Participant: ' || v_nom_part || ' (ID: ' || v_no_part || '), Total Score: ' || v_total_score);
    END LOOP;

    -- Fermer le curseur
    CLOSE crsr_participants;
END;
/



-- Exercice 12. VARIANTE 01
DECLARE
    v_nom_competition VARCHAR2(100);
    CURSOR crsr_participants (p_nom_competition VARCHAR2) IS
        SELECT p.NO_PART, p.NOM_PART, SUM(s.NOTE) AS TOTAL_SCORE
        FROM PARTICIPANT p
        JOIN SCORE s ON p.NO_PART = s.NO_PAR
        JOIN COMPETITION c ON s.CODE_COMP = c.CODE_COMP
        WHERE c.NOM_COMPETITION = p_nom_competition
        GROUP BY p.NO_PART, p.NOM_PART;
        
    v_no_part PARTICIPANT.NO_PART%TYPE;
    v_nom_part PARTICIPANT.NOM_PART%TYPE;
    v_total_score NUMBER;
BEGIN
    -- Lire le nom de la compétition depuis la console
    v_nom_competition := '&v_nom_competition';

    -- Ouvrir le curseur
    OPEN crsr_participants(v_nom_competition);

    -- Récupérer les participants et leurs scores totaux
    LOOP
        FETCH crsr_participants INTO v_no_part, v_nom_part, v_total_score;
        EXIT WHEN crsr_participants%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Participant: ' || v_nom_part || ' (ID: ' || v_no_part || '), Total Score: ' || v_total_score);
    END LOOP;

    -- Fermer le curseur
    CLOSE crsr_participants;
END;
/
