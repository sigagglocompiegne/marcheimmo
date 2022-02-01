-- si local indépendant divisé ou un terrain
CASE WHEN {ityp} = '22' or {ityp} = '10' THEN
    --si le libellé de l'occupant est vide 
	CASE WHEN 
	(
	SELECT lib_occup FROM m_economie.an_immo_bien WHERE idimmo = {idimmo}
	) = '' or 
	--si le libellé de l'occupant est null 
	(
	SELECT lib_occup FROM m_economie.an_immo_bien WHERE idimmo = {idimmo}
	) IS NULL
	THEN
	-- alors j'affiche l'étiquette du libellé
	(
	SELECT libelle FROM m_economie.an_immo_bien WHERE idimmo = {idimmo}
	) 
	-- sinon j'affiche de libellé de l'occupant
	ELSE
	(
	SELECT lib_occup FROM m_economie.an_immo_bien WHERE idimmo = {idimmo}
	)
	END

-- si pas un local indépendant divisé ou pas un terrain
ELSE 
    -- gestion affichage des étiquettes en fonction du nombre d'établissements occupant
	CASE 
	-- si il y a 1 à 2 établissements rattachés aux bâtiments alors on les affiches
	WHEN (SELECT count(*) FROM m_economie.lk_immo_batiadr a , m_economie.lk_adresseetablissement e, m_economie.an_sa_etab ae, s_sirene.an_etablissement_api ne 
		WHERE a.id_adresse = e.idadresse AND e.siret = ne.siret AND e.siret = ae.idsiret AND ae.l_compte = true AND ne.etatadministratifetablissement = 'A' AND left(ae.idsiret,9) NOT IN
	 	(SELECT siren FROM  m_economie.an_sa_etab_rad)
		AND a.idbati = {idbati}) BETWEEN 1 AND 2
		THEN
		-- affiche le nom du bâtiment et les 2 premiers établissements avec ... 
		-- affiche le nom du bâtiment si pas une adresse et les 2 premiers établissements avec ... 
		CASE WHEN (SELECT count(*) FROM x_apps.xapps_geo_vmr_immo_bati WHERE idbati = {idbati} AND bati_nom IS TRUE) = 0 THEN '' ELSE
		(SELECT libelle FROM x_apps.xapps_geo_vmr_immo_bati WHERE idbati = {idbati})
		|| chr(10)
		END
		||
		-- affiche la liste
		(SELECT etiquette FROM x_apps.xapps_geo_vmr_immo_bati WHERE idbati = {idbati})
        
	-- si plus de 2 établissements ont affiche le nom du bâtiments + les 2 premiers établissements
	WHEN (SELECT count(*) FROM m_economie.lk_immo_batiadr a , m_economie.lk_adresseetablissement e, m_economie.an_sa_etab ae, s_sirene.an_etablissement_api ne 
		WHERE a.id_adresse = e.idadresse AND e.siret = ne.siret AND e.siret = ae.idsiret AND ae.l_compte = true AND ne.etatadministratifetablissement = 'A' AND left(ae.idsiret,9) NOT IN
	 	(SELECT siren FROM  m_economie.an_sa_etab_rad)
		AND a.idbati = {idbati}) > 2
		THEN
		-- affiche le nom du bâtiment si pas une adresse) et les 2 premiers établissements avec ... 
		CASE WHEN (SELECT count(*) FROM x_apps.xapps_geo_vmr_immo_bati WHERE idbati = {idbati} AND bati_nom IS TRUE) = 0 THEN '' ELSE
		(SELECT libelle FROM x_apps.xapps_geo_vmr_immo_bati WHERE idbati = {idbati})
		|| chr(10)
		END
		||
		
		-- ici tableau dans lequel je prends les 2 premières éléments que j'aggrège
		(SELECT array_to_string((array_agg( 
										 CASE
                    WHEN length(ae.l_nom::text) <> 0 THEN ae.l_nom
                    WHEN length(ne.enseigne1etablissement::text) <> 0 THEN ne.enseigne1etablissement
                    WHEN length(ne.enseigne2etablissement::text) <> 0 THEN ne.enseigne2etablissement
                    WHEN length(ne.enseigne3etablissement::text) <> 0 THEN ne.enseigne3etablissement
                    WHEN length(ne.denominationusuelleetablissement::text) <> 0 THEN ne.denominationusuelleetablissement
                    WHEN length(t2.denominationunitelegale::text) <> 0 THEN t2.denominationunitelegale
                    WHEN length(t2.denominationusuelle1unitelegale::text) <> 0 THEN t2.denominationusuelle1unitelegale
                    WHEN length(t2.denominationusuelle2unitelegale::text) <> 0 THEN t2.denominationusuelle2unitelegale
                    WHEN length(t2.denominationusuelle3unitelegale::text) <> 0 THEN t2.denominationusuelle3unitelegale
                    WHEN length(t2.nomunitelegale::text) <> 0 THEN t2.nomunitelegale
                    WHEN length(t2.nomusageunitelegale::text) <> 0 THEN t2.nomusageunitelegale
                    WHEN length(t2.pseudonymeunitelegale::text) <> 0 THEN t2.pseudonymeunitelegale
                    ELSE ''::character varying
                END::text))[1:2], chr(10)) 
		 
		           FROM m_economie.an_immo_bati ba,
            m_economie.lk_immo_batiadr a,
            m_economie.lk_adresseetablissement e_1,
            m_economie.an_sa_etab ae,
            s_sirene.an_etablissement_api ne
	         JOIN ( SELECT an_unitelegale_api.siren,
                    max(an_unitelegale_api.gid) AS max,
                    an_unitelegale_api.denominationunitelegale,
                    an_unitelegale_api.denominationusuelle1unitelegale,
                    an_unitelegale_api.denominationusuelle2unitelegale,
                    an_unitelegale_api.denominationusuelle3unitelegale,
                    an_unitelegale_api.nomunitelegale,
                    an_unitelegale_api.nomusageunitelegale,
                    an_unitelegale_api.pseudonymeunitelegale
                   FROM s_sirene.an_unitelegale_api 
                  GROUP BY an_unitelegale_api.siren, an_unitelegale_api.denominationunitelegale, an_unitelegale_api.denominationusuelle1unitelegale, 
				   an_unitelegale_api.denominationusuelle2unitelegale, an_unitelegale_api.denominationusuelle3unitelegale, an_unitelegale_api.nomunitelegale, 
				   an_unitelegale_api.nomusageunitelegale, an_unitelegale_api.pseudonymeunitelegale) t2 
		  ON ne.siren::text = t2.siren::text
		  WHERE ba.idbati = a.idbati 
		  AND a.id_adresse = e_1.idadresse 
		  AND e_1.siret::text = ne.siret::text 
		  AND e_1.siret::text = ae.idsiret::text AND ae.l_compte = true 
		  AND ne.etatadministratifetablissement::text = 'A'::text
		  AND ba.idbati = {idbati}
		  GROUP BY ba.idbati
		  )
		  	  
		  || chr(10) || '...'
	-- si aucun établissement rattachés aux bâtiments ET si deS locaux saisie avec un occupant
	WHEN ((SELECT count(*) FROM m_economie.lk_immo_batiadr a , m_economie.lk_adresseetablissement e, m_economie.an_sa_etab ae, s_sirene.an_etablissement_api ne 
		WHERE a.id_adresse = e.idadresse AND e.siret = ne.siret AND e.siret = ae.idsiret AND ae.l_compte = true AND ne.etatadministratifetablissement = 'A' AND left(ae.idsiret,9) NOT IN
	 	(SELECT siren FROM  m_economie.an_sa_etab_rad)
		AND a.idbati = {idbati} )= 0)
		AND
		((SELECT COUNT(*) FROM m_economie.an_immo_bien bi, m_economie.geo_immo_bien o
			WHERE bi.idimmo = o.idimmo AND (bi.lib_occup IS NOT NULL OR bi.lib_occup <> '') AND o.idbati = {idbati}) > 0)
		THEN
		-- alors j'affiche la liste des occupants non référebncé SIRENE
		(SELECT string_agg(
			(CASE WHEN length(lib_occup) = 0 THEN libelle ELSE lib_occup END)
			,chr(10)) 
			FROM m_economie.an_immo_bien bi, m_economie.geo_immo_bien o 
		    WHERE bi.idimmo = o.idimmo AND o.idbati = {idbati})
	ELSE
	-- sinon j'affiche le libellé du bâtiment
	(SELECT etiquette FROM x_apps.xapps_geo_vmr_immo_bati WHERE idbati = {idbati})
	END
	
END
