/*
Script para identificar utilização de indice no banco de dados SQL Server
*/
SELECT  
    OBJECT_NAME(DMI.OBJECT_ID) AS TBL_NAME,
    I.NAME AS IDX_NAME
    DMI.*
FROM
    SYS.DM_DB_INDEX_USAGE_STATUS DMI
    JOIN SYS.INDEXES I
        ON DMI.INDEX_ID = I.INDEX_ID
            AND DMI.OBJECT_ID = I.OBJECT_ID
WHERE DATABASE_ID = DB_ID()
    AND OBJECT_NAME(DMI.OBJECT_ID) IN ('Nome Tabela')
ORDER BY 
    USER_UPDATES DESC;

/*
USER_SEEKS - Operações está utilizando o indice de forma concreta, indo diretamente na informação necessária utilizando o indice
USER_SCANS - Operação está sendo realizada usando a consulta ao indice todo para conseguir a informção necessária (o indice pode está fragmentado)
USER_LOCKUPS - Operação utiliza parte do indice para buscar outra informação no banco 
USER_UPDATES - Atualizações do Indice, se esse número for muito grande ele vai gerar mais custo que vantagem 
*/