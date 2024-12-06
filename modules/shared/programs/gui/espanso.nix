{
  services.espanso = {
    enable = true;

    matches = {
      base = {
        matches = [
          {
            replace = "Canyon, TX";
            trigger = ";loc";
          }
          {
            replace = "Canyon";
            trigger = ";ct";
          }
          {
            replace = "Codesmith Software Engineering Residency for Experienced Programmers";
            trigger = ";csl";
          }
          {
            replace = "140000";
            trigger = ";comp";
          }
          {
            replace = "01/03/1997";
            trigger = ";dob";
          }
          {
            replace = "347JakeJanzen@gmail.com";
            trigger = ";dem";
          }
          {
            replace = "katiejanzen@347online.me";
            trigger = ";pem";
          }
          {
            replace = "Katie";
            trigger = ";fn";
          }
          {
            replace = "Katie Janzen";
            trigger = ";n";
          }
          {
            replace = "https://github.com/347Online";
            trigger = ";gh";
          }
          {
            replace = "Janzen";
            trigger = ";ln";
          }
          {
            replace = "https://www.linkedin.com/in/katie-janzen/";
            trigger = ";li";
          }
          {
            replace = "1410 Ponderosa St Unit 231 Canyon, TX, 79015";
            trigger = ";mail";
          }
          {
            replace = "8066546933";
            trigger = ";ph";
          }
          {
            replace = "she/her/hers";
            trigger = ";pro";
          }
          {
            replace = "1410 Ponderosa St";
            trigger = ";sta";
          }
          {
            replace = "Unit 231";
            trigger = ";stu";
          }
          {
            replace = "https://347online.me";
            trigger = ";ws";
          }
          {
            replace = "79015";
            trigger = ";zc";
          }
          {
            replace = "accessibility";
            trigger = "a11y";
          }
          {
            replace = "💀";
            trigger = ":skull:";
          }
        ];
      };
    };

  };
}
