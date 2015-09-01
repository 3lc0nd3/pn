package co.com.elramireza.pn.dao;

import co.com.elramireza.pn.model.*;
import co.com.elramireza.pn.util.MyKey;
import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.hibernate.exception.ConstraintViolationException;
import org.hibernate.*;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;
import java.io.*;

import static java.lang.String.format;

import java.math.BigDecimal;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Timestamp;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 2/01/2013
 * Time: 05:48:15 PM
 */
@SuppressWarnings({
		"deprecation", "unchecked"
})
public class PnDAO extends HibernateDaoSupport{

	public SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
	public SimpleDateFormat dfDateTime  = new SimpleDateFormat("dd/MM/yyyy KK:mm aaa");
	public SimpleDateFormat dfNameMonth = new SimpleDateFormat("dd MMMMMM yyyy");
	public SimpleDateFormat dfNameMonthHour = new SimpleDateFormat("dd MMMMMM yyyy KK:mm aaa");

	public String test(String s){
		logger.debug("s = " + s);
		return "Hola " + s;
	}

    public List<PnAgendaInvitado> getPnAgendaInvitadosFromParticipante(int idParticipante){
        return getHibernateTemplate().find(
                "from PnAgendaInvitado where pnAgendaByIdAgenda.participanteByIdParticipante.idParticipante = ? order by hora",
                idParticipante
        );
    }
	
	
	public int resetTableIncrement(String tableName){
		try {
			org.hibernate.Session hbSession = getSession();
			Transaction hbTs = hbSession.beginTransaction();
			SQLQuery query = hbSession.createSQLQuery(String.format("ALTER TABLE %s AUTO_INCREMENT =1", tableName));
			query.executeUpdate();
			hbTs.commit();
			hbSession.close();
			return 1;
		} catch (DataAccessResourceFailureException e) {
			e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
			return 0;
		} catch (IllegalStateException e) {
			e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
			return 0;
		} catch (HibernateException e) {
			e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
			return 0;
		}
	}

    public int saveInvitadoEnPnAgenda(PnAgendaInvitado invitado){
        try {
            WebContext wctx = WebContextFactory.get();
            HttpSession session = wctx.getSession(true);
            final Empleado empleado = (Empleado) session.getAttribute("empleo");

            Participante participanteByIdParticipante = empleado.getParticipanteByIdParticipante();
            //LO RECARGO PORQUE PUEDE ESTAR CAMBIANDO EN EL AIRE
            participanteByIdParticipante = getParticipante(participanteByIdParticipante.getIdParticipante());
            PnEtapaParticipante etapaParticipante = participanteByIdParticipante.getPnEtapaParticipanteByIdEtapaParticipante();
            if(etapaParticipante.getIdEtapaParticipante()!=3){ // AGENDA
            throw new SecurityException("No puede escribir datos. El Participante se encuentra en etapa: "+
                        etapaParticipante.getEtapaParticipante());
            }

            Timestamp timestamp = new Timestamp(System.currentTimeMillis());

            invitado.setPnAgendaByIdAgenda(getPnAgendaFromParticipante(participanteByIdParticipante.getIdParticipante()));
            invitado.setPnSubCapituloByIdPnSubcapitulo(getPnSubCapitulo(invitado.getIdItem()));

            getHibernateTemplate().save(invitado);
            return 1;
        } catch (DataAccessException e) {
//            e.printStackTrace();
            logger.debug(e.getMessage());
            return 0;
        }
    }

    public int guardaNotasAgenda(String nota){
        try {
            WebContext wctx = WebContextFactory.get();
            HttpSession session = wctx.getSession(true);
            final Empleado empleado = (Empleado) session.getAttribute("empleo");

            Participante participanteByIdParticipante = empleado.getParticipanteByIdParticipante();
            //LO RECARGO PORQUE PUEDE ESTAR CAMBIANDO EN EL AIRE
            participanteByIdParticipante = getParticipante(participanteByIdParticipante.getIdParticipante());
            PnEtapaParticipante etapaParticipante = participanteByIdParticipante.getPnEtapaParticipanteByIdEtapaParticipante();
            if(etapaParticipante.getIdEtapaParticipante()!=3){ // AGENDA
                throw new SecurityException("No puede escribir datos. El Participante se encuentra en etapa: "+
                        etapaParticipante.getEtapaParticipante());
            }
            PnAgenda agenda = getPnAgendaFromParticipante(participanteByIdParticipante.getIdParticipante());
            agenda.setNotas(nota);
            getHibernateTemplate().update(agenda);
            return 1;
        } catch (SecurityException e) {
            e.printStackTrace();
            logger.debug(e.getMessage());
            return 0;
        } catch (DataAccessException e) {
            e.printStackTrace();
            logger.debug(e.getMessage());
            return 0;
        }

    }

    public PnAgenda getPnAgendaFromParticipante(int idParticipante){
        List<PnAgenda> pnAgendas = getHibernateTemplate().find(
                "from PnAgenda where participanteByIdParticipante.idParticipante = ? ",
                idParticipante);
        if(pnAgendas.size()>0){
            return pnAgendas.get(0);
        } else {
            return null;
        }
    }

    /**
     * Guarda la agenda. Si ya existe la debe actualizar.
     * @param fechaS
     * @return
     */
    public int saveAgenda(String fechaS){
        try {
            WebContext wctx = WebContextFactory.get();
            HttpSession session = wctx.getSession(true);
            final Empleado empleado = (Empleado) session.getAttribute("empleo");

            //LO RECARGO PORQUE PUEDE ESTAR CAMBIANDO EN EL AIRE
            final Participante participanteByIdParticipante = getParticipante(
                    empleado.getParticipanteByIdParticipante().getIdParticipante()
            );
            PnEtapaParticipante etapaParticipante = participanteByIdParticipante.getPnEtapaParticipanteByIdEtapaParticipante();
            if(etapaParticipante.getIdEtapaParticipante()!=3 ){ // AGENDA
                throw new SecurityException("No puede escribir datos. El Participante se encuentra en etapa: "+
                        etapaParticipante.getEtapaParticipante());
            }

            final Timestamp fechaAgenda = new Timestamp(df.parse(fechaS).getTime());
            final Timestamp timestamp = new Timestamp(System.currentTimeMillis());

            //  REVISO SI YA TIENE AGENDA.

            PnAgenda agendaOld = getPnAgendaFromParticipante(participanteByIdParticipante.getIdParticipante());
            if(agendaOld != null){  //  YA TIENE
                getHibernateTemplate().execute(new HibernateCallback() {
                    public Object doInHibernate(org.hibernate.Session session) throws HibernateException, SQLException {
                        Query query = session.createQuery(
                                "update PnAgenda set fechaAgenda=?, fechaCreacion=? where participanteByIdParticipante.idParticipante = ?"
                        );
                        query.setTimestamp(0, fechaAgenda); // EMPLEADO - DEPENDE DE PARTICIPANTE
                        query.setTimestamp(1, timestamp); // EMPLEADO - DEPENDE DE PARTICIPANTE
                        query.setInteger(2, participanteByIdParticipante.getIdParticipante()); // EMPLEADO - DEPENDE DE PARTICIPANTE
                        query.executeUpdate();
                        return null;
                    }
                });
                return 1;
            } else {  //  NO TIENE AGENDA
                PnAgenda pnAgenda = new PnAgenda();
                pnAgenda.setParticipanteByIdParticipante(participanteByIdParticipante);
                pnAgenda.setEmpleadoByIdEmpleadoCreador(empleado);
                pnAgenda.setFechaAgenda(fechaAgenda);
                pnAgenda.setFechaCreacion(timestamp);
                getHibernateTemplate().save(pnAgenda);
                return 1;
            }  //  END IF TIENE AGENDA
        } catch (DataAccessException e) {
//            e.printStackTrace();
            logger.debug(e.getMessage());
            return 0;
        } catch (ParseException e) {
//            e.printStackTrace();
            logger.debug(e.getMessage());
            return 0;
        }
    }

    public PnAgenda getPnAgenda(int id){
        return (PnAgenda) getHibernateTemplate().get(PnAgenda.class, id);
    }

	public List<TipoCargoEmpleado> getTipoCargoEmpleados(){
		return getHibernateTemplate().find("from TipoCargoEmpleado order by tipoCargo ");
	}

    /**
     * segun el nombre del servicio
     * @param servicio
     * @return
     */
    public Servicio getServicioFromName(String servicio){
        List<Servicio> list = getHibernateTemplate().find(
                "from Servicio where servicio = ?",
                servicio );
        if(list.size()>0){
            return list.get(0);
        } else {
            return null;
        }
    }

	public Servicio getServicio(int id){
		return (Servicio) getHibernateTemplate().get(Servicio.class, id);
	}

	public List<Servicio> getServiciosAjaxPublicos(){
		return getHibernateTemplate().find("from Servicio where tipo = 'a' and publico = 1");
	}

	public List<Servicio> getServiciosPublicosVisibles(){
		return getHibernateTemplate().find("from Servicio where visible = 1 and publico = 1 order by orden ");
	}

    public List<ServicioRol> getServiciosFromPerfil(int idPerfil){
        return getHibernateTemplate().find(
                "from ServicioRol where perfilByIdRol.id = ? and servicioByIdServicio.visible=1 order by servicioByIdServicio.orden",
                idPerfil);
    }

    /**
     * borra si se puede
     * @param idCriterio id
     * @return 1 ok, 0 DB error, 2 dependencias
     */
    public int deleteCriterioAdmin(int idCriterio){
        try {
            List<PnValoracion> valoraciones = getHibernateTemplate().find(
                    "from PnValoracion where pnCriterioByIdPnCriterio.id=?",
                    idCriterio
            );
            if(valoraciones.size()>0){
                return 2;
            } else {
                PnCriterio criterio = getPnCriterio(idCriterio);
                getHibernateTemplate().delete(criterio);
                return 1;
            }
        } catch (DataAccessException e) {
//            e.printStackTrace();
            logger.debug(e.getMessage());
            return 0;
        }
    }

    /**
     * Add criterio vacio a una Categoria de criterio
     * @param idCategoriaCriterio
     * @return
     */
    public int addCriterioAdmin(int idCategoriaCriterio){
        try {
            PnCriterio criterio = new PnCriterio();
            criterio.setPnCategoriaCriterioByIdCategoriaCriterio(getPnCategoriaCriterio(idCategoriaCriterio));
            criterio.setCriterio("nuevo");
            getHibernateTemplate().save(criterio);
            return 1;
        } catch (DataAccessException e) {
//            e.printStackTrace();
            logger.debug(e.getMessage());
            return 0;
        }
    }

    public List<PnCategoriaCriterio> getCategoriasCriterio(int idTipoPremio){
        return getHibernateTemplate().find(
                "from PnCategoriaCriterio where pnTipoPremioById.id = ? order by id ",
                idTipoPremio
        );
    }

    public List<Empleado> getEmpleadosFromParticipante(int idParticipante){
        return getHibernateTemplate().find(
                "from Empleado where participanteByIdParticipante.idParticipante = ? ",
                idParticipante);
    }

    public boolean saltoEtapaIndividualGrupal(int idParticipante){ 
        List<Empleado> empleados;
        empleados = getEvaluadoresFromParticipante(idParticipante);

        boolean salta = true;
        boolean hayLider = false;

        for (Empleado empleado : empleados){
            logger.debug("empleado.getPersonaByIdPersona().getNombreCompleto() = " + empleado.getPersonaByIdPersona().getNombreCompleto());
            //REVISO VALORACION IND GLOBAL
            /*List<PnValoracion> valoracionGlobal = getValoracionIndividualGlobalFromEmpleado(empleado.getIdEmpleado());
            if(valoracionGlobal.size() == 0){
                salta = false;
            }*/
            logger.debug("Ind. Global: " + empleado.isEvaluaGlobal());

            //REVISO VALORACION IND CAPITULOS
            /*List<PnValoracion> valoraciones = getValoracionIndividualCapitulosFromEmpleado(empleado.getIdEmpleado());
            if(valoraciones.size() == 0){
                salta = false;
            }*/
            logger.debug("Ind. Cap.: " + empleado.isEvaluaCapitulos());

            //REVISO CUANTITATIVA
            /*List<PnCuantitativa> cuantitativas = getCuantitativaIndividualFromEmpleado(empleado.getIdEmpleado());
            if(cuantitativas.size() == 0){
                salta = false;
            }*/
            logger.debug("Cuantitativa: " + empleado.isEvaluaItems());

            //REVISO SI HAY LIDER
            if(empleado.getPerfilByIdPerfil().getId() == 7){
                hayLider = true;
            }
            logger.debug("hayLider = " + hayLider);

			if (!(empleado.isEvaluaGlobal() && empleado.isEvaluaCapitulos() && empleado.isEvaluaItems())) { // SI NO CUMPLE UN EMPLEADO NO SALTA
				salta = false;
			}
			
        }
        // SALTA O NO
        if(salta && hayLider){
            logger.debug("SI SALTA");
            Participante participante = getParticipante(idParticipante);
            PnEtapaParticipante pnEtapaParticipante = getPnEtapaParticipante(2);
            participante.setPnEtapaParticipanteByIdEtapaParticipante(pnEtapaParticipante);
            getHibernateTemplate().update(participante);
        } else {
            logger.debug("NO SALTA");
        }
        return salta;
    }

    public List<Empleado> getEvaluadoresFromParticipante(int idParticipante){
        return getHibernateTemplate().find(
                "from Empleado where participanteByIdParticipante.idParticipante = ? and (perfilByIdPerfil.id = 2 or perfilByIdPerfil.id = 7) order by perfilByIdPerfil.id desc , personaByIdPersona.nombrePersona",
                idParticipante);
    }

    public List<PnCriterio> getPnCriterios(int idTipoPremio){
        return getHibernateTemplate().find("from PnCriterio where " +
                " pnCategoriaCriterioByIdCategoriaCriterio.pnTipoPremioById.id = ? " +
                " order by id",
                idTipoPremio);
    }

    public List<PnCriterio> getPnCriteriosFromCategoria(int idCategoria){
        return getHibernateTemplate().find(
                "from PnCriterio where pnCategoriaCriterioByIdCategoriaCriterio.id = ? order by id ",
                idCategoria
        );
    }

    public List <PnCuantitativa> getCuantitativaDespuesVisitaFromEmpleado(int idEmpleado){
        return getHibernateTemplate().find(
                "from PnCuantitativa where tipoFormatoByIdTipoFormato.id = 5 and empleadoByIdEmpleado.idEmpleado = ?",
                idEmpleado
        );
    }

    public List <PnCuantitativa> getCuantitativaConsensoFromEmpleado(int idEmpleado){
        return getHibernateTemplate().find(
                "from PnCuantitativa where tipoFormatoByIdTipoFormato.id = 4 and empleadoByIdEmpleado.idEmpleado = ?",
                idEmpleado
        );
    }

    public List <PnCuantitativa> getCuantitativaIndividualFromEmpleado(int idEmpleado){
        return getHibernateTemplate().find(
                "from PnCuantitativa where tipoFormatoByIdTipoFormato.id = 3 and empleadoByIdEmpleado.idEmpleado = ? " +
                        " order by pnSubCapituloByIdSubCapitulo.pnCapituloByIdCapitulo.numeroCapitulo, pnSubCapituloByIdSubCapitulo.codigoItem",
                idEmpleado
        );
    }

	public List<MyKey> getTotalesItems(int idEmpleado, int idTipoFormato){
		String hql;
		hql = "select pnSubCapituloByIdSubCapitulo.pnCapituloByIdCapitulo.id, " +
                " pnSubCapituloByIdSubCapitulo.pnCapituloByIdCapitulo.nombreCapitulo, " +
                " sum(total) from PnCuantitativa " +
                " where tipoFormatoByIdTipoFormato.id = ? and empleadoByIdEmpleado.idEmpleado = ? " +
                " group by pnSubCapituloByIdSubCapitulo.pnCapituloByIdCapitulo";
		Object o[] = {idTipoFormato, idEmpleado};
		List<Object[]> sumas = getHibernateTemplate().find(
				hql, 
				o);
		List<MyKey> totales = new ArrayList<MyKey>();
		for (Object[] objects : sumas) {
			MyKey key = new MyKey();
			key.setId((Integer) objects[0]);
			key.setText((String) objects[1]);
			key.setValue((new BigDecimal((Long) objects[2])).intValue());
			logger.debug("objects[0] = " + objects[0] +"\tobjects[1] = " + objects[1] + "\tbjects[2] = " + objects[2]);
			totales.add(key);
		}
		return totales;
	}

    public List<PnValoracion> getValoracionIndividualGlobalFromEmpleado(int idEmpleado){
        return getHibernateTemplate().find(
                "from PnValoracion where tipoFormatoByIdTipoFormato.id = 1 and empleadoByIdEmpleado.idEmpleado = ?",
                idEmpleado
        );
    }

    public List<PnValoracion> getValoracionConsensoGlobalFromEmpleado(int idEmpleado){
        return getHibernateTemplate().find(
                "from PnValoracion where tipoFormatoByIdTipoFormato.id = 6 and empleadoByIdEmpleado.idEmpleado = ?",
                idEmpleado
        );
    }

    public List<PnValoracion> getValoracionIndividualCapitulosFromEmpleado(int idEmpleado){
        return getHibernateTemplate().find(
                "from PnValoracion where tipoFormatoByIdTipoFormato.id = 2 and empleadoByIdEmpleado.idEmpleado = ?",
                idEmpleado
        );
    }

    public List<PnValoracion> getValoracionConsensoCapitulosFromEmpleado(int idEmpleado){
        return getHibernateTemplate().find(
                "from PnValoracion where tipoFormatoByIdTipoFormato.id = 7 and empleadoByIdEmpleado.idEmpleado = ?",
                idEmpleado
        );
    }

    public List<PnCualitativa> getPnCualitativasFromEmpleadoTipoFormato(int idEmpleado,
                                                                        int tipoFormato){
        Object o[] = {idEmpleado, tipoFormato};
        List<PnCualitativa> pnCualitativas = getHibernateTemplate().find(
                "from PnCualitativa where empleadoByIdEmpleado.idEmpleado = ? and tipoFormatoByIdTipoFormato.id = ?",
                o
        );
        return pnCualitativas;
    }

    public static final String d = "";

    /**
     * Actualiza Valores en Admon Tipo Premio
     * @param idTipoPremio
     * @param id
     * @param value
     * @param t
     * @param f
     * @return
     */
    public int actualizaPrincipioCalificacion(final int idTipoPremio,
                                              final int id,
                                              final String value,
                                              final String t,
                                              final String f){
        WebContext wctx = WebContextFactory.get();
        HttpSession session = wctx.getSession(true);
        final Empleado empleado = (Empleado) session.getAttribute("empleo");
        logger.debug("empleado = " + empleado);
        getHibernateTemplate().execute(new HibernateCallback() {
            public Object doInHibernate(org.hibernate.Session session) throws HibernateException, SQLException {
                String s = "update "+t+" set " + f + " = ? where id = ?";
                if (!t.equals("PnCriterio") && !t.equals("PnSubCapitulo")) {
                    s +=" and pnTipoPremioById.id =?";
                }
                logger.debug("s = " + s);
                Query query = session.createQuery(
                        s
                );
                query.setString(0, value); // el nuevo texto
                query.setInteger(1, id); // EMPLEADO - DEPENDE DE PARTICIPANTE
                if (!t.equals("PnCriterio") && !t.equals("PnSubCapitulo")) {
                    query.setInteger(2, idTipoPremio); // TIPO FORMATO
                }
                query.executeUpdate();
                return null;
            }
        });
        return 1;
    }

    /**
     * Update un texto
     * @param tipoFormato
     * @param idCapitulo
     * @param txt
     * @param target nombre de la columna afectada. fortalezas oportunidades pendientesVisita vision
     * @return
     */
    public PnCualitativa actualizaCualitativa(final int tipoFormato,
                                              final int idCapitulo,
                                              final String txt,
                                              final String target){
        logger.debug("tipoFormato = " + tipoFormato);
        logger.debug("idCapitulo = " + idCapitulo);
        logger.debug("txt = " + txt);
        logger.debug("target = " + target);

        WebContext wctx = WebContextFactory.get();
        HttpSession session = wctx.getSession(true);
        final Empleado empleado = (Empleado) session.getAttribute("empleo");
        logger.debug("empleado = " + empleado);


        getHibernateTemplate().execute(new HibernateCallback() {
            public Object doInHibernate(org.hibernate.Session session) throws HibernateException, SQLException {
                String s =
                        "update PnCualitativa set " + target + " = ? where empleadoByIdEmpleado.id = ? and tipoFormatoByIdTipoFormato.id = ? ";
                if(idCapitulo != 0){
                    s += " and pnCapituloByIdCapitulo.id = ?";
                }
                Query query = session.createQuery(
                        s
                );
                query.setString(0, txt); // el nuevo texto
                query.setInteger(1, empleado.getIdEmpleado()); // EMPLEADO - DEPENDE DE PARTICIPANTE
                query.setInteger(2, tipoFormato); // TIPO FORMATO
                if(idCapitulo!=0){
                    query.setInteger(3, idCapitulo); // TIPO FORMATO
                }
                query.executeUpdate();
                return null;
            }
        });
        return getPnCualitativa(tipoFormato, idCapitulo, empleado);
    }

    public PnRetroalimentacion actualizaRetroalimentacion(final int idParticipante,
                                                          final int idCapitulo,
                                                          final String txt,
                                                          final String target){
        getHibernateTemplate().execute(new HibernateCallback() {
            @Override
            public Object doInHibernate(Session session) throws HibernateException, SQLException {
                Query query = session.createQuery(
                        "update PnRetroalimentacion set " + target + " = ? where participanteByIdParticipante.id = ? and pnCapituloByIdPnCapitulo.id = ?"
                );
                query.setString(0, txt);
                query.setInteger(1, idParticipante);
                query.setInteger(2, idCapitulo);
                query.executeUpdate();
                return null;
            }
        });
        return getPnRetroalimentacion(idParticipante, idCapitulo);
    }

    /**
     * Get PnCualitativa
     * @param tipoFormato
     * @param idCapitulo 0 si es NULL para GLOBAL
     * @return la PnCualitativa, si no existe, crea una vacia y la retorna. o Usar getPnCualitativaFromEmpleadoTipoFormato
     */
    public PnCualitativa getPnCualitativa(int tipoFormato,
                                          int idCapitulo,
                                          Empleado empleado){
        if (empleado == null) {
            WebContext wctx = WebContextFactory.get();
            HttpSession session = wctx.getSession(true);
            empleado = (Empleado) session.getAttribute("empleo");
        }

        if(idCapitulo == 0){
            PnCualitativa cualitativa = getPnCualitativaFromEmpleadoTipoFormato(empleado.getIdEmpleado(), tipoFormato);
            if(cualitativa == null){
                return saveCualitativaVacia(tipoFormato, idCapitulo, empleado);
            } else {
                return cualitativa;
            }
        } else {
            Object o[] = {empleado.getIdEmpleado(), tipoFormato, idCapitulo};
            List<PnCualitativa> pnCualitativas = getHibernateTemplate().find(
                    " from PnCualitativa where empleadoByIdEmpleado.idEmpleado = ? and tipoFormatoByIdTipoFormato.id = ? and " +
                            "pnCapituloByIdCapitulo.id = ?",
                    o
            );
            if(pnCualitativas.size()>0){
                return pnCualitativas.get(0);
            } else {
                return saveCualitativaVacia(tipoFormato, idCapitulo, empleado);
            }
        }
    }

    public PnRetroalimentacion getPnRetroalimentacion(int idParticipante,
                                                      int idCapitulo){
        Object o[] = {idParticipante, idCapitulo};

        List<PnRetroalimentacion> retros = getHibernateTemplate().find(
                "from PnRetroalimentacion where participanteByIdParticipante.id = ? and pnCapituloByIdPnCapitulo.id = ?",
                o
        );
        if(retros.size()>0){
            return retros.get(0);
        } else {
            return saveRetroalimentacionVacia( idParticipante, idCapitulo);
        }
    }

    /**
     * La cualitativa vacia
     * @param tipoFormato
     * @param idCapitulo
     * @param empleado
     * @return
     */
    public PnCualitativa saveCualitativaVacia(int tipoFormato,
                                              int idCapitulo,
                                              Empleado empleado){

        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        PnCualitativa cualitativa = new PnCualitativa();

        cualitativa.setTipoFormatoByIdTipoFormato(getTipoFormato(tipoFormato));
        cualitativa.setParticipanteByIdParticipante(empleado.getParticipanteByIdParticipante());
        cualitativa.setEmpleadoByIdEmpleado(empleado);
        if(idCapitulo != 0){
            cualitativa.setPnCapituloByIdCapitulo(getPnCapitulo(idCapitulo));
        }
        cualitativa.setFechaCreacion(timestamp);
        cualitativa.setVision("");
        cualitativa.setFortalezas("");
        cualitativa.setOportunidades("");
        cualitativa.setPendientesVisita("");

        Integer id = (Integer) getHibernateTemplate().save(cualitativa);

        cualitativa.setId(id);
        logger.debug("cualitativa.getId() = " + cualitativa.getId());
        return cualitativa;
    }

    public PnRetroalimentacion saveRetroalimentacionVacia(int idParticipante,
                                                          int idCapitulo){
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        PnRetroalimentacion retroalimentacion = new PnRetroalimentacion();

        retroalimentacion.setFortalezas("");
        retroalimentacion.setOportunidades("");
        retroalimentacion.setParticipanteByIdParticipante(getParticipante(idParticipante));
        retroalimentacion.setPnCapituloByIdPnCapitulo(getPnCapitulo(idCapitulo));
        retroalimentacion.setFechaCreacion(timestamp);
        getHibernateTemplate().save(retroalimentacion);
        return retroalimentacion;
    }

    public PnCualitativa getPnCualitativaFromEmpleadoTipoFormato(int idEmpleado,
                                                                 int tipoFormato){
        Object o[] = {idEmpleado, tipoFormato};
        List<PnCualitativa> pnCualitativas = getHibernateTemplate().find(
                "from PnCualitativa where empleadoByIdEmpleado.idEmpleado = ? and tipoFormatoByIdTipoFormato.id = ?",
                o
        );
        if(pnCualitativas.size()>0){
            return pnCualitativas.get(0);
        } else {
            return null;
        }
    }

    public List<PnCapitulo> getPnCapitulos(int idTipoPremio){
        return getHibernateTemplate().find("from PnCapitulo where " +
                " pnTipoPremioById.id=? order by numeroCapitulo ",
                idTipoPremio);
    }

    public List<PnSubCapitulo> getPnSubCapitulos(int idTipoPremio){
        return getHibernateTemplate().find("from PnSubCapitulo " +
                " where pnCapituloByIdCapitulo.pnTipoPremioById.id=? order by pnCapituloByIdCapitulo.numeroCapitulo, codigoItem ",
                idTipoPremio);
    }

    public int saveValoracionIndividualItems(boolean definitivo,
											 List<MyKey> valores){
		logger.debug("definitivo = " + definitivo);
        try {
            WebContext wctx = WebContextFactory.get();
            HttpSession session = wctx.getSession(true);
            final Empleado empleado = (Empleado) session.getAttribute("empleo");

            Participante participanteByIdParticipante = empleado.getParticipanteByIdParticipante();
            //LO RECARGO PORQUE PUEDE ESTAR CAMBIANDO EN EL AIRE
            participanteByIdParticipante = getParticipante(participanteByIdParticipante.getIdParticipante());
            PnEtapaParticipante etapaParticipante = participanteByIdParticipante.getPnEtapaParticipanteByIdEtapaParticipante();
            if(etapaParticipante.getIdEtapaParticipante()!=1){
                throw new SecurityException("No puede escribir datos. El Participante se encuentra en etapa: "+
                        etapaParticipante.getEtapaParticipante());
            }

            //Borro los datos Anteriores
            Timestamp timestamp = new Timestamp(System.currentTimeMillis());
            getHibernateTemplate().execute(new HibernateCallback() {
                public Object doInHibernate(org.hibernate.Session session) throws HibernateException, SQLException {
                    Query query = session.createQuery(
                            "delete from PnCuantitativa where empleadoByIdEmpleado.idEmpleado = ? and tipoFormatoByIdTipoFormato.id = ?"
                    );
                    query.setInteger(0, empleado.getIdEmpleado()); // EMPLEADO - DEPENDE DE PARTICIPANTE
                    query.setInteger(1, 3); // TIPO FORMATO
                    query.executeUpdate();
                    return null;
                }
            });

			resetTableIncrement("pn_cuantitativa");

            for (MyKey key: valores){
                PnCuantitativa valor = new PnCuantitativa();
                valor.setTipoFormatoByIdTipoFormato(getTipoFormato(3)); // items individual
                valor.setParticipanteByIdParticipante(participanteByIdParticipante);
                valor.setEmpleadoByIdEmpleado(empleado);
                PnSubCapitulo pnSubCapitulo = getPnSubCapitulo(key.getId());
                valor.setPnSubCapituloByIdSubCapitulo(pnSubCapitulo);
                valor.setValor(key.getCriterio()); // VALOR
//                valor.setTotal(key.getValue()); // TOTAL - ANTIGUO
                valor.setTotal((int) Math.ceil(((double)pnSubCapitulo.getPonderacion() * (double)key.getCriterio()) / 100.0)); // TOTAL
                valor.setFechaCreacion(timestamp);
                getHibernateTemplate().save(valor);
            }

			// GUARDA FINAL - DEFINITIVO
			if (definitivo) {
				Empleado empleadoOld = getEmpleado(empleado.getIdEmpleado());
				empleadoOld.setEvaluaItems(true);
				getHibernateTemplate().update(empleadoOld);
				session.setAttribute("empleo", empleadoOld);
			}

            // REVISA SI HAY SALTO A GRUPAL
            saltoEtapaIndividualGrupal(participanteByIdParticipante.getIdParticipante());

            return 1;
        } catch (DataAccessException e) {
            e.printStackTrace();
            logger.debug(e.getMessage());
            return 0;
        } catch (Exception e){
			e.printStackTrace();
			logger.debug(e.getMessage());
			return 0;
		}
    }

    /**
     * con ajax
     * @param idCapitulo
     * @param txt
     * @param target
     * @return
     */
    public PnRetroalimentacion actualizaDespuesVisitaItems(final int idCapitulo,
                                                           final String txt,
                                                           final String target){
        WebContext wctx = WebContextFactory.get();
        HttpSession session = wctx.getSession(true);
        final Empleado empleado = (Empleado) session.getAttribute("empleo");
        logger.debug("empleado = " + empleado);

        getHibernateTemplate().execute(new HibernateCallback() {
            @Override
            public Object doInHibernate(Session session) throws HibernateException, SQLException {
                Query query = session.createQuery(
                        "update PnRetroalimentacion set "+target+" = ? where participanteByIdParticipante.id=? and pnCapituloByIdPnCapitulo.id = ?"
                );

                query.setString(0, txt);
                query.setInteger(1, empleado.getParticipanteByIdParticipante().getIdParticipante());
                query.setInteger(2, idCapitulo);

                query.executeUpdate();
                return null;  //To change body of implemented methods use File | Settings | F
            }
        });
        return getPnRetroalimentacion(empleado.getParticipanteByIdParticipante().getIdParticipante(),idCapitulo);
    }

    public int saveValoracionDespuesVisitaItems(List<MyKey> valores,
												List<MyKey> retro){
        try {
            WebContext wctx = WebContextFactory.get();
            HttpSession session = wctx.getSession(true);
            final Empleado empleado = (Empleado) session.getAttribute("empleo");

            Participante participanteByIdParticipante = empleado.getParticipanteByIdParticipante();
            //LO RECARGO PORQUE PUEDE ESTAR CAMBIANDO EN EL AIRE
            participanteByIdParticipante = getParticipante(participanteByIdParticipante.getIdParticipante());
            PnEtapaParticipante etapaParticipante = participanteByIdParticipante.getPnEtapaParticipanteByIdEtapaParticipante();
            if(etapaParticipante.getIdEtapaParticipante()!=4){ // REVISAR LA ETAPA -
                throw new SecurityException("No puede escribir datos. El Participante se encuentra en etapa: "+
                        etapaParticipante.getEtapaParticipante());
            }

            Timestamp timestamp = new Timestamp(System.currentTimeMillis());
            getHibernateTemplate().execute(new HibernateCallback() {
                public Object doInHibernate(org.hibernate.Session session) throws HibernateException, SQLException {
                    Query query = session.createQuery(
                            "delete from PnCuantitativa where empleadoByIdEmpleado.idEmpleado = ? and tipoFormatoByIdTipoFormato.id = ?"
                    );
                    query.setInteger(0, empleado.getIdEmpleado()); // EMPLEADO - DEPENDE DE PARTICIPANTE
                    query.setInteger(1, 5); // TIPO FORMATO DESPUES DE VISITA
                    query.executeUpdate();
                    return null;
                }
            });

            /*getHibernateTemplate().execute(new HibernateCallback() {
                public Object doInHibernate(org.hibernate.Session session) throws HibernateException, SQLException {
                    Query query = session.createQuery(
                            "delete from PnRetroalimentacion where participanteByIdParticipante.idParticipante= ?"
                    );
                    query.setInteger(0, empleado.getParticipanteByIdParticipante().getIdParticipante()); //  PARTICIPANTE
                    query.executeUpdate();
                    return null;
                }
            });

            for (MyKey key: retro){
				logger.debug("key.getId() = " + key.getId());
				logger.debug("key.getText() = " + key.getText());
				logger.debug("key.getText2() = " + key.getText2());
				PnRetroalimentacion retroalimentacion = new PnRetroalimentacion();
				retroalimentacion.setParticipanteByIdParticipante(participanteByIdParticipante);
				retroalimentacion.setPnCapituloByIdPnCapitulo(getPnCapitulo(key.getId()));
				retroalimentacion.setFortalezas(key.getText());
				retroalimentacion.setOportunidades(key.getText2());
				retroalimentacion.setFechaCreacion(timestamp);
				getHibernateTemplate().save(retroalimentacion);
			}*/
            for (MyKey key: valores){
                PnCuantitativa valor = new PnCuantitativa();
                valor.setTipoFormatoByIdTipoFormato(getTipoFormato(5)); // items Consenso
                valor.setParticipanteByIdParticipante(participanteByIdParticipante);
                valor.setEmpleadoByIdEmpleado(empleado);
                PnSubCapitulo pnSubCapitulo = getPnSubCapitulo(key.getId());
                valor.setPnSubCapituloByIdSubCapitulo(pnSubCapitulo);
                valor.setValor(key.getCriterio()); // VALOR
//                valor.setTotal(key.getValue()); // TOTAL - ANTIGUO
                valor.setTotal((int) Math.ceil(((double)pnSubCapitulo.getPonderacion() * (double)key.getCriterio()) / 100.0)); // TOTAL
                valor.setFechaCreacion(timestamp);
                getHibernateTemplate().save(valor);
            }

            return 1;
        } catch (DataAccessException e) {
//            e.printStackTrace();
            logger.debug(e.getMessage());
            return 0;
        }
    }
	
	public List<PnRetroalimentacion> getPnRetroalimentaciones(int idParticipante){
		return getHibernateTemplate().find(
				"from PnRetroalimentacion where participanteByIdParticipante.idParticipante = ?",
				idParticipante);
	}

    public int saveValoracionConsensoItems(List<MyKey> valores){
        try {
            WebContext wctx = WebContextFactory.get();
            HttpSession session = wctx.getSession(true);
            final Empleado empleado = (Empleado) session.getAttribute("empleo");

            Participante participanteByIdParticipante = empleado.getParticipanteByIdParticipante();
            //LO RECARGO PORQUE PUEDE ESTAR CAMBIANDO EN EL AIRE
            participanteByIdParticipante = getParticipante(participanteByIdParticipante.getIdParticipante());
            PnEtapaParticipante etapaParticipante = participanteByIdParticipante.getPnEtapaParticipanteByIdEtapaParticipante();
            if(etapaParticipante.getIdEtapaParticipante()!=2){ // REVISAR LA ETAPA -
                throw new SecurityException("No puede escribir datos. El Participante se encuentra en etapa: "+
                        etapaParticipante.getEtapaParticipante());
            }

            Timestamp timestamp = new Timestamp(System.currentTimeMillis());
            getHibernateTemplate().execute(new HibernateCallback() {
                public Object doInHibernate(org.hibernate.Session session) throws HibernateException, SQLException {
                    Query query = session.createQuery(
                            "delete from PnCuantitativa where empleadoByIdEmpleado.idEmpleado = ? and tipoFormatoByIdTipoFormato.id = ?"
                    );
                    query.setInteger(0, empleado.getIdEmpleado()); // EMPLEADO - DEPENDE DE PARTICIPANTE
                    query.setInteger(1, 4); // TIPO FORMATO   Consenso
                    query.executeUpdate();
                    return null;
                }
            });

            for (MyKey key: valores){
                PnCuantitativa valor = new PnCuantitativa();
                valor.setTipoFormatoByIdTipoFormato(getTipoFormato(4)); // items Consenso
                valor.setParticipanteByIdParticipante(participanteByIdParticipante);
                valor.setEmpleadoByIdEmpleado(empleado);
                PnSubCapitulo pnSubCapitulo = getPnSubCapitulo(key.getId());
                valor.setPnSubCapituloByIdSubCapitulo(pnSubCapitulo);
                valor.setValor(key.getCriterio()); // VALOR
//                valor.setTotal(key.getValue()); // TOTAL - ANTIGUO
                valor.setTotal((int) Math.ceil(((double)pnSubCapitulo.getPonderacion() * (double)key.getCriterio()) / 100.0)); // TOTAL
                valor.setFechaCreacion(timestamp);
                getHibernateTemplate().save(valor);
            }

            return 1;
        } catch (DataAccessException e) {
//            e.printStackTrace();
            logger.debug(e.getMessage());
            return 0;
        }
    }

    public int saltaAVisita(){
        try {
            WebContext wctx = WebContextFactory.get();
            HttpSession session = wctx.getSession(true);
            final Empleado empleado = (Empleado) session.getAttribute("empleo");

            Participante participanteByIdParticipante = empleado.getParticipanteByIdParticipante();
            PnEtapaParticipante pnEtapaParticipante = getPnEtapaParticipante(3); // AGENDA VISITA
            participanteByIdParticipante.setPnEtapaParticipanteByIdEtapaParticipante(pnEtapaParticipante);
            getHibernateTemplate().update(participanteByIdParticipante);
            return 1;
        } catch (DataAccessException e) {
//            e.printStackTrace();
            logger.debug(e.getMessage());
            return 0;
        }
    }

    public int saltaADespuesDeVisita(){
		logger.debug("entro = ");
        try {
            WebContext wctx = WebContextFactory.get();
            HttpSession session = wctx.getSession(true);
            final Empleado empleado = (Empleado) session.getAttribute("empleo");

            Participante participanteByIdParticipante = empleado.getParticipanteByIdParticipante();
            PnEtapaParticipante pnEtapaParticipante = getPnEtapaParticipante(4); // DESPUES DE AGENDA VISITA
            participanteByIdParticipante.setPnEtapaParticipanteByIdEtapaParticipante(pnEtapaParticipante);
            getHibernateTemplate().update(participanteByIdParticipante);
            return 1;
        } catch (DataAccessException e) {
//            e.printStackTrace();
            logger.debug(e.getMessage());
            return 0;
        }

    }

    /**
     * salta a Etapa 5
     * @return
     */
    public int saltaAFinalDelProceso(){
        logger.debug("entro = saltaAFinalDelProceso");
        try {
            WebContext wctx = WebContextFactory.get();
            HttpSession session = wctx.getSession(true);
            final Empleado empleado = (Empleado) session.getAttribute("empleo");

            Participante participanteByIdParticipante = empleado.getParticipanteByIdParticipante();
            PnEtapaParticipante pnEtapaParticipante = getPnEtapaParticipante(5); // FINAL
            participanteByIdParticipante.setPnEtapaParticipanteByIdEtapaParticipante(pnEtapaParticipante);
            getHibernateTemplate().update(participanteByIdParticipante);
            return 1;
        } catch (DataAccessException e) {
//            e.printStackTrace();
            logger.debug(e.getMessage());
            return 0;
        }
    }

    public int saveValoracionIndividualCapitulos(boolean definitivo,
                                                 List<MyKey> valores
                                                 ){
		logger.debug("definitivo = " + definitivo);
        try {
            WebContext wctx = WebContextFactory.get();
            HttpSession session = wctx.getSession(true);
            final Empleado empleado = (Empleado) session.getAttribute("empleo");


            Participante participanteByIdParticipante = empleado.getParticipanteByIdParticipante();
            //LO RECARGO PORQUE PUEDE ESTAR CAMBIANDO EN EL AIRE
            participanteByIdParticipante = getParticipante(participanteByIdParticipante.getIdParticipante());
            PnEtapaParticipante etapaParticipante = participanteByIdParticipante.getPnEtapaParticipanteByIdEtapaParticipante();
            if(etapaParticipante.getIdEtapaParticipante()!=1){
                throw new SecurityException("No puede escribir datos. El Participante se encuentra en etapa: "+
                        etapaParticipante.getEtapaParticipante());
            }

            Timestamp timestamp = new Timestamp(System.currentTimeMillis());
            getHibernateTemplate().execute(new HibernateCallback() {
                public Object doInHibernate(org.hibernate.Session session) throws HibernateException, SQLException {
                    Query query = session.createQuery(
                            "delete from PnValoracion where empleadoByIdEmpleado.idEmpleado = ? and tipoFormatoByIdTipoFormato.id = ?"
                    );
                    query.setInteger(0, empleado.getIdEmpleado());
                    query.setInteger(1, 2);
                    query.executeUpdate();

                    return null;
                }
            });

			resetTableIncrement("pn_valoracion");

			TipoFormato tipoFormato = getTipoFormato(2);
			for (MyKey key : valores) {
    //            logger.debug("ints = " + ints[0] + "\t" + ints[1]);
                PnValoracion valor = new PnValoracion();
                valor.setEmpleadoByIdEmpleado(empleado);
                valor.setTipoFormatoByIdTipoFormato(tipoFormato);
                valor.setParticipanteByIdParticipante(empleado.getParticipanteByIdParticipante());
                valor.setPnCapituloByIdCapitulo(getPnCapitulo(key.getId()));
                valor.setPnCriterioByIdPnCriterio(getPnCriterio(key.getCriterio()));
                valor.setValor(key.getValue());
                valor.setFecha(timestamp);
                getHibernateTemplate().save(valor);
            }

			// GUARDA FINAL - DEFINITIVO
			if (definitivo) {
				Empleado empleadoOld = getEmpleado(empleado.getIdEmpleado());
				empleadoOld.setEvaluaCapitulos(true);
				getHibernateTemplate().update(empleadoOld);
				session.setAttribute("empleo", empleadoOld);
			}

            // REVISA SI HAY SALTO A GRUPAL
            saltoEtapaIndividualGrupal(participanteByIdParticipante.getIdParticipante());

            return 1;
        } catch (DataAccessException e) {
//            e.printStackTrace();
            logger.debug(e.getMessage());
            return 0;
        }
    }

	public int saveValoracionConsensoCapitulos(boolean definitivo,
											   /*List<MyKey> visiones,
											   List<MyKey> fortalezas,
											   List<MyKey> opertunidades,
											   List<MyKey> pendientes,*/
											   List<MyKey> valores
	){
//		logger.debug("definitivo = " + definitivo);
        try {
            WebContext wctx = WebContextFactory.get();
            HttpSession session = wctx.getSession(true);
            final Empleado empleado = (Empleado) session.getAttribute("empleo");


            Participante participanteByIdParticipante = empleado.getParticipanteByIdParticipante();
            //LO RECARGO PORQUE PUEDE ESTAR CAMBIANDO EN EL AIRE
            participanteByIdParticipante = getParticipante(participanteByIdParticipante.getIdParticipante());
            PnEtapaParticipante etapaParticipante = participanteByIdParticipante.getPnEtapaParticipanteByIdEtapaParticipante();
            if(etapaParticipante.getIdEtapaParticipante()!=2){
                throw new SecurityException("No puede escribir datos. El Participante se encuentra en etapa: "+
                        etapaParticipante.getEtapaParticipante());
            }

            Timestamp timestamp = new Timestamp(System.currentTimeMillis());
            getHibernateTemplate().execute(new HibernateCallback() {
                public Object doInHibernate(org.hibernate.Session session) throws HibernateException, SQLException {
                    Query query = session.createQuery(
                            "delete from PnValoracion where empleadoByIdEmpleado.idEmpleado = ? and tipoFormatoByIdTipoFormato.id = ?"
                    );
                    query.setInteger(0, empleado.getIdEmpleado());
                    query.setInteger(1, 7);  // CONSENSO CAPS
                    query.executeUpdate();

                    /*Query query1 = session.createQuery(
                            "delete from PnCualitativa where empleadoByIdEmpleado.idEmpleado = ? and tipoFormatoByIdTipoFormato.id = ?");
                    query1.setInteger(0, empleado.getIdEmpleado());
                    query1.setInteger(1, 7); // CONSENSO CAPS
                    query1.executeUpdate();*/
                    return null;
                }
            });

			resetTableIncrement("pn_valoracion");
//			resetTableIncrement("pn_cualitativa");

			TipoFormato tipoFormato = getTipoFormato(7); // CONSENSO CAPS
			for (MyKey key : valores) {
    //            logger.debug("ints = " + ints[0] + "\t" + ints[1]);
                PnValoracion valor = new PnValoracion();
                valor.setEmpleadoByIdEmpleado(empleado);
                valor.setTipoFormatoByIdTipoFormato(tipoFormato);
                valor.setParticipanteByIdParticipante(empleado.getParticipanteByIdParticipante());
                valor.setPnCapituloByIdCapitulo(getPnCapitulo(key.getId()));
                valor.setPnCriterioByIdPnCriterio(getPnCriterio(key.getCriterio()));
                valor.setValor(key.getValue());
                valor.setFecha(timestamp);
                getHibernateTemplate().save(valor);
            }


            /*for (int i = 0; i < fortalezas.size(); i++) {
                MyKey keyVision      	= visiones.get(i);
                MyKey keyFortaleza      = fortalezas.get(i);
                MyKey keyOportunidad    = opertunidades.get(i);
                MyKey keyPendiente      = pendientes.get(i);

    //            logger.debug("e.getKey() = " + keyFortaleza.getId() + "\te.getValue() = " + keyFortaleza.getValue() + "\tname " + keyFortaleza.getText());

                PnCapitulo capitulo = getPnCapitulo(keyFortaleza.getId());
                logger.debug("");
                logger.debug("");
                logger.debug("");
                logger.debug("capitulo.getNombreCapitulo() = " + capitulo.getNombreCapitulo());

                PnCualitativa cualitativa = new PnCualitativa();
                cualitativa.setTipoFormatoByIdTipoFormato(tipoFormato);
                cualitativa.setParticipanteByIdParticipante(empleado.getParticipanteByIdParticipante());
                cualitativa.setEmpleadoByIdEmpleado(empleado);
                cualitativa.setPnCapituloByIdCapitulo(capitulo);
                cualitativa.setFechaCreacion(timestamp);

				logger.debug("vision cap = " + keyVision.getText());
				cualitativa.setVision(keyVision.getText());
                logger.debug("fortalezas = " + keyFortaleza.getText());
                cualitativa.setFortalezas(keyFortaleza.getText());
                logger.debug("oportunidades = " + keyOportunidad.getText());
                cualitativa.setOportunidades(keyOportunidad.getText());
                logger.debug("pendientesVisita = " + keyPendiente.getText());
                cualitativa.setPendientesVisita(keyPendiente.getText());

                Integer idCualitativa = (Integer) getHibernateTemplate().save(cualitativa);

            }*/

			// GUARDA FINAL - DEFINITIVO
			/*if (definitivo) {
				Empleado empleadoOld = getEmpleado(empleado.getIdEmpleado());
				empleadoOld.setEvaluaCapitulos(true);
				getHibernateTemplate().update(empleadoOld);
				session.setAttribute("empleo", empleadoOld);
			}*/

            // REVISA SI HAY SALTO A GRUPAL
//            saltoEtapaIndividualGrupal(participanteByIdParticipante.getIdParticipante());

            return 1;
        } catch (DataAccessException e) {
//            e.printStackTrace();
            logger.debug(e.getMessage());
            return 0;
        }
    }

	public int saveVAloracionIndividual(boolean definitivo,
										int v[][],
										String vision,
										String fortalezas,
										String oportunidades,
										String pendientesVisita){
		logger.debug("definitivo = " + definitivo);
		try {
            WebContext wctx = WebContextFactory.get();
            HttpSession session = wctx.getSession(true);
            final Empleado empleado = (Empleado) session.getAttribute("empleo");


            Participante participanteByIdParticipante = empleado.getParticipanteByIdParticipante();
            //LO RECARGO PORQUE PUEDE ESTAR CAMBIANDO EN EL AIRE
            participanteByIdParticipante = getParticipante(participanteByIdParticipante.getIdParticipante());
            PnEtapaParticipante etapaParticipante = participanteByIdParticipante.getPnEtapaParticipanteByIdEtapaParticipante();
            if(etapaParticipante.getIdEtapaParticipante()!=1){
                throw new SecurityException("No puede escribir datos. El Participante se encuentra en etapa: "+
                etapaParticipante.getEtapaParticipante());
            }

            //Borro los datos Anteriores
            getHibernateTemplate().execute(new HibernateCallback() {
                public Object doInHibernate(org.hibernate.Session session) throws HibernateException, SQLException {
                    Query query = session.createQuery(
                            "delete from PnValoracion where empleadoByIdEmpleado.idEmpleado = ? and tipoFormatoByIdTipoFormato.id = ?"
                    );
                    query.setInteger(0, empleado.getIdEmpleado());
                    query.setInteger(1, 1);
                    query.executeUpdate();

                    Query query1 = session.createQuery(
                            "delete from PnCualitativa where empleadoByIdEmpleado.idEmpleado = ? and tipoFormatoByIdTipoFormato.id = ?");
                    query1.setInteger(0, empleado.getIdEmpleado());
                    query1.setInteger(1, 1);
                    query1.executeUpdate();
                    return null;
                }
            });

			resetTableIncrement("pn_valoracion");
			resetTableIncrement("pn_cualitativa");

            Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			TipoFormato tipoFormato = getTipoFormato(1);  // INDIVIDUAL
			for (int[] ints : v) {
                logger.debug("ints = " + ints[0] + "\t" + ints[1]);
                PnValoracion valor = new PnValoracion();
                valor.setEmpleadoByIdEmpleado(empleado);
                valor.setTipoFormatoByIdTipoFormato(tipoFormato);
                valor.setParticipanteByIdParticipante(empleado.getParticipanteByIdParticipante());
                valor.setPnCapituloByIdCapitulo(null);
                valor.setPnCriterioByIdPnCriterio(getPnCriterio(ints[0]));
                valor.setValor(ints[1]);
                valor.setFecha(timestamp);
                getHibernateTemplate().save(valor);
            }

            PnCualitativa cualitativa = new PnCualitativa();
            cualitativa.setTipoFormatoByIdTipoFormato(tipoFormato);
            cualitativa.setParticipanteByIdParticipante(empleado.getParticipanteByIdParticipante());
            cualitativa.setEmpleadoByIdEmpleado(empleado);
            cualitativa.setPnCapituloByIdCapitulo(null);
            cualitativa.setFechaCreacion(timestamp);
			logger.debug("vision = " + vision);
			cualitativa.setVision(vision);
            logger.debug("fortalezas = " + fortalezas);
            cualitativa.setFortalezas(fortalezas);
            logger.debug("oportunidades = " + oportunidades);
            cualitativa.setOportunidades(oportunidades);
            logger.debug("pendientesVisita = " + pendientesVisita);
            cualitativa.setPendientesVisita(pendientesVisita);

            Integer idCualitativa = (Integer) getHibernateTemplate().save(cualitativa);
            logger.debug("idCualitativa = " + idCualitativa);

			// GUARDA FINAL - DEFINITIVO
			if (definitivo) {
				Empleado empleadoOld = getEmpleado(empleado.getIdEmpleado());
				empleadoOld.setEvaluaGlobal(true);
				getHibernateTemplate().update(empleadoOld);
				session.setAttribute("empleo", empleadoOld);
			}

            // REVISA SI HAY SALTO A GRUPAL
            saltoEtapaIndividualGrupal(participanteByIdParticipante.getIdParticipante());

            return 1;
        } catch (DataAccessException e) {
            e.printStackTrace();
            logger.debug(e.getMessage());
            return 0;
        } catch (Exception e){
			e.printStackTrace();
			logger.debug(e.getMessage());
			return 0;
		}
    }

	public int saveValoracionConsensoGlobal(boolean definitivo,
											int v[][],
											String vision,
											String fortalezas,
											String oportunidades,
											String pendientesVisita){
//		logger.debug("definitivo = " + definitivo);
		try {
			//Borro los datos Anteriores
			WebContext wctx = WebContextFactory.get();
			HttpSession session = wctx.getSession(true);
            final Empleado empleado = (Empleado) session.getAttribute("empleo");


            Participante participanteByIdParticipante = empleado.getParticipanteByIdParticipante();
            //LO RECARGO PORQUE PUEDE ESTAR CAMBIANDO EN EL AIRE
            participanteByIdParticipante = getParticipante(participanteByIdParticipante.getIdParticipante());
            PnEtapaParticipante etapaParticipante = participanteByIdParticipante.getPnEtapaParticipanteByIdEtapaParticipante();
            if(etapaParticipante.getIdEtapaParticipante()!=2){
                throw new SecurityException("No puede escribir datos. El Participante se encuentra en etapa: "+
                etapaParticipante.getEtapaParticipante());
            }

            getHibernateTemplate().execute(new HibernateCallback() {
                public Object doInHibernate(org.hibernate.Session session) throws HibernateException, SQLException {
                    Query query = session.createQuery(
                            "delete from PnValoracion where empleadoByIdEmpleado.idEmpleado = ? and tipoFormatoByIdTipoFormato.id = ?"
                    );
                    query.setInteger(0, empleado.getIdEmpleado());
                    query.setInteger(1, 6); // 6 CONSENSO GLOBAL
                    query.executeUpdate();

                    Query query1 = session.createQuery(
                            "delete from PnCualitativa where empleadoByIdEmpleado.idEmpleado = ? and tipoFormatoByIdTipoFormato.id = ?");
                    query1.setInteger(0, empleado.getIdEmpleado());
                    query1.setInteger(1, 6);  // 6 CONSENSO GLOBAL
                    query1.executeUpdate();
                    return null;
                }
            });

			resetTableIncrement("pn_valoracion");
			resetTableIncrement("pn_cualitativa");

            Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			TipoFormato tipoFormato = getTipoFormato(6);  // 6 CONSENSO GLOBAL
			for (int[] ints : v) {
                logger.debug("ints = " + ints[0] + "\t" + ints[1]);
                PnValoracion valor = new PnValoracion();
                valor.setEmpleadoByIdEmpleado(empleado);
                valor.setTipoFormatoByIdTipoFormato(tipoFormato);
                valor.setParticipanteByIdParticipante(empleado.getParticipanteByIdParticipante());
                valor.setPnCapituloByIdCapitulo(null);
                valor.setPnCriterioByIdPnCriterio(getPnCriterio(ints[0]));
                valor.setValor(ints[1]);
                valor.setFecha(timestamp);
                getHibernateTemplate().save(valor);
            }

            PnCualitativa cualitativa = new PnCualitativa();
            cualitativa.setTipoFormatoByIdTipoFormato(tipoFormato);
            cualitativa.setParticipanteByIdParticipante(empleado.getParticipanteByIdParticipante());
            cualitativa.setEmpleadoByIdEmpleado(empleado);
            cualitativa.setPnCapituloByIdCapitulo(null);
            cualitativa.setFechaCreacion(timestamp);
			logger.debug("vision = " + vision);
			cualitativa.setVision(vision);
            logger.debug("fortalezas = " + fortalezas);
            cualitativa.setFortalezas(fortalezas);
            logger.debug("oportunidades = " + oportunidades);
            cualitativa.setOportunidades(oportunidades);
            logger.debug("pendientesVisita = " + pendientesVisita);
            cualitativa.setPendientesVisita(pendientesVisita);

            Integer idCualitativa = (Integer) getHibernateTemplate().save(cualitativa);
            logger.debug("idCualitativa = " + idCualitativa);

			// GUARDA FINAL - DEFINITIVO
			/*if (definitivo) {
				Empleado empleadoOld = getEmpleado(empleado.getIdEmpleado());
				empleadoOld.setEvaluaGlobal(true);
				getHibernateTemplate().update(empleadoOld);
				session.setAttribute("empleo", empleadoOld);
			}
*/
            // REVISA SI HAY SALTO A GRUPAL
//            saltoEtapaIndividualGrupal(participanteByIdParticipante.getIdParticipante());

            return 1;
        } catch (DataAccessException e) {
            e.printStackTrace();
            logger.debug(e.getMessage());
            return 0;
        }
    }



    public PnSubCapitulo getPnSubCapitulo(int id){
        return (PnSubCapitulo) getHibernateTemplate().get(PnSubCapitulo.class, id);
    }

    public PnCapitulo getPnCapitulo(int id){
        return (PnCapitulo) getHibernateTemplate().get(PnCapitulo.class, id);
    }

    public List<Integer> getValoresValoracion(){
        List<Integer> valores = new ArrayList<Integer>();
        for (Integer i= 0; i<=100; i+=5){
            valores.add(i);
        }
        return valores;
    }

    public PnCriterio getPnCriterio(int id){
        return (PnCriterio) getHibernateTemplate().get(PnCriterio.class, id);
    }

    public PnCategoriaCriterio getPnCategoriaCriterio(int id){
        return (PnCategoriaCriterio) getHibernateTemplate().get(PnCategoriaCriterio.class, id);
    }

    public TipoFormato getTipoFormato(int id){
        return (TipoFormato) getHibernateTemplate().get(TipoFormato.class, id);
    }

	public Texto getTexto(int id){
		Texto texto = (Texto) getHibernateTemplate().get(Texto.class, id);
		if(texto==null){
			texto =  new Texto();
			texto.setTexto1(format("No hay texto %d", id));
			texto.setTexto2("");
			texto.setTexto3("");
		}
		return texto;
	}

	public List<Texto> getTextosSlider(String idSlider){
		return getHibernateTemplate().find(
				"from Texto where tipo = ? order by id ",
				idSlider
		);
	}

	public List<LocEstado> getLocEstados(){
		return getHibernateTemplate().find("from LocEstado ");
	}

	public List<LocCiudad> getLocCiudadesFromEstado(int idEstado){
		return getHibernateTemplate().find("from LocCiudad where locEstadoByIdEstado.idEstado = ? ",
				idEstado);
	}

	public List<Empresa> getEmpresas(){
		return getHibernateTemplate().find("from Empresa ");
	}

	public List<Empresa> getEmpresaActivas(){
		return getHibernateTemplate().find("from Empresa where idEmpresa > 1 and estado = true");
	}

	public List<Empleado> getEmpleados(){
		return getHibernateTemplate().find("from Empleado where participanteByIdParticipante.empresaByIdEmpresa.idEmpresa <> 1 order by participanteByIdParticipante.empresaByIdEmpresa.nombreEmpresa , personaByIdPersona.nombrePersona , personaByIdPersona.apellido ");
	}


	public List<Empleado> getEmpleadosInterno(){
		return getHibernateTemplate().find("from Empleado where participanteByIdParticipante.empresaByIdEmpresa.idEmpresa = 1 order by participanteByIdParticipante.empresaByIdEmpresa.nombreEmpresa , personaByIdPersona.nombrePersona , personaByIdPersona.apellido ");
	}

	public Empleado getEmpleado(int idEmpleado){
		return (Empleado) getHibernateTemplate().get(Empleado.class, idEmpleado);
	}

	public String desvinculaEmpleado(int idEmpleado){
		try {
			Empleado empleado = getEmpleado(idEmpleado);
			getHibernateTemplate().delete(empleado);
			return "";
		} catch (ConstraintViolationException e) {
            logger.debug(e.getMessage());
			return (e.getMessage());
		} catch (DataAccessException e) {
			logger.debug(e.getMessage());
			return (e.getMessage());

		}
	}

    /**
     *
     * @param idEmpleado
     * @return
     */
	public String activateEmpleado(int idEmpleado){
		try {
			Empleado empleado = getEmpleado(idEmpleado);
            Persona laPersona = empleado.getPersonaByIdPersona();

            //  1. activar la persona.
            laPersona.setEstado(true);
            getHibernateTemplate().update(laPersona);

            //  2. notifica y envia password.
            notificaEmpleadoVinculo(empleado);

			return "";
		} catch (ConstraintViolationException e) {
            logger.debug(e.getMessage());
			return (e.getMessage());
		} catch (DataAccessException e) {
			logger.debug(e.getMessage());
			return (e.getMessage());

		}
	}



	public List<Perfil> getPerfiles(){
		return getHibernateTemplate().find("from Perfil order by perfil ");
	}

	public Empleado vinculaEmpleado(int idPersona,
									int idParticipante,
									int idCargo,
									int idPerfil){
		logger.debug("idParticipante = " + idParticipante);
		try {
			Empleado empleado = new Empleado();
			empleado.setPerfilByIdPerfil(getPerfil(idPerfil));
			empleado.setPersonaByIdPersona(getPersona(idPersona));
			empleado.setCargoEmpleadoByIdCargo(getCargoEmpleado(idCargo));
			empleado.setParticipanteByIdParticipante(getParticipante(idParticipante));
			empleado.setFechaIngreso(new Timestamp(System.currentTimeMillis()));


            Integer idEmpleado = (Integer) getHibernateTemplate().save(empleado);
//			System.out.println("idEmpleado 1 = " + idEmpleado);

			if(idEmpleado != null){
				try {
					notificaEmpleadoVinculo(empleado);
				} catch (Exception e) {
					e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
				}
			}

			empleado.setIdEmpleado(idEmpleado);
//			System.out.println("idEmpleado = " + idEmpleado);
			return empleado;
		} catch (ConstraintViolationException e) {
			logger.debug(e.getMessage());
			return null;
		} catch (DataAccessException e) {
			logger.debug(e.getMessage());
			return null;
		} catch (Exception e){
			logger.debug(e.getMessage());
			return null;
		}
	}

	public void notificaEmpleadoVinculo(Empleado empleado){
		Persona personaByIdPersona = getPersona(empleado.getPersonaByIdPersona().getIdPersona());
		logger.debug("personaByIdPersona = " + personaByIdPersona);
		String asunto = "Vinculado - " + empleado.getParticipanteByIdParticipante().getPnPremioByIdConvocatoria().getNombrePremio()+
                ", " + empleado.getParticipanteByIdParticipante().getEmpresaByIdEmpresa().getNombreEmpresa();
		logger.debug("asunto = " + asunto);
		String mensaje =
				"Cordial saludo" +
						"<br>" +
						"<br>" +
						"Le informamos que usted ha sido vinculado al siguiente proceso: " +
				        "<br>" +
						"Premio: " + empleado.getParticipanteByIdParticipante().getPnPremioByIdConvocatoria().getNombrePremio()+
						"<br>" +
						"Empresa: " + empleado.getParticipanteByIdParticipante().getEmpresaByIdEmpresa().getNombreEmpresa() +
						"<br>" +
						"Cargo: " + empleado.getCargoEmpleadoByIdCargo().getCargo() +
						"<br>" +
						"Perfil en el Sistema: " + empleado.getPerfilByIdPerfil().getPerfil() +
						"	<br>" +
						"Login: " + personaByIdPersona.getEmailPersonal() +
						"<br>" +
						""
				;
		logger.debug("mensaje = " + mensaje);
		if (personaByIdPersona.getPassword() == null || personaByIdPersona.getPassword().equals("")) { //  SI NO TIENE PASSWORD
			logger.debug("no tiene password");
			String password = getRandomPassword();
			logger.debug("password = " + password);
			personaByIdPersona.setPassword(getMD5(password));
			getHibernateTemplate().update(personaByIdPersona);
			mensaje += "Password: " + password;
		}
		logger.debug("mensaje = " + mensaje);
		String[] emails = {personaByIdPersona.getEmailPersonal()};
		enviaEmail(emails, asunto, mensaje, null, SUSCRIBE);
	}

	public int desvincularParticipante(int idParticipante){
		try {
			Participante participante = getParticipante(idParticipante);
			getHibernateTemplate().delete(participante);
			return 1;
		} catch (DataAccessException e) {
			logger.debug(e.getMessage());
			return 0;
		}
	}

	public List<Participante> getParticipantes(PnTipoPremio tipoPremio){
		return getHibernateTemplate().find(
                "from Participante where " +
                        " empresaByIdEmpresa.tipoEmpresaByIdTipoEmpresa.id = 2 " +
                        " and " +
                        " pnPremioByIdConvocatoria.tipoPremioById.id = ? " +
                        " order by pnPremioByIdConvocatoria.nombrePremio, empresaByIdEmpresa.nombreEmpresa ",
                tipoPremio.getId()
                );
	}

	public List<Participante> getParticipantesFromPremio(int idPremio){
		return getHibernateTemplate().find("from Participante where pnPremioByIdConvocatoria.idPnPremio = ? ",
				idPremio);
	}

	public List<EmpresaCategoria> getEmpresaCategorias(){
		return getHibernateTemplate().find("from EmpresaCategoria ");
	}

	public List<EmpresaCategoriaTamano> getEmpresaCategoriaTamanos(){
		return getHibernateTemplate().find("from EmpresaCategoriaTamano ");
	}

	public List<CargoEmpleado> getCargoEmpleadosParticipante(){
		return getHibernateTemplate().find("from CargoEmpleado where tipoCargoEmpleadoByIdTipoCargo.id = 2");
	}

	public List<CargoEmpleado> getCargoEmpleadosInterno(){
		return getHibernateTemplate().find("from CargoEmpleado where tipoCargoEmpleadoByIdTipoCargo.id = 1");
	}

	public int saveEmpresa(Empresa empresa){
		return (Integer) getHibernateTemplate().save(empresa);
	}

	public int saveEmpresaR(Empresa empresa){
		Empresa empresaOld = getEmpresaFromNit(empresa.getNit());

		empresa.setLocCiudadByIdCiudad(getCiudad(empresa.getLocCiudadEmpresa()));
		empresa.setFechaCreacion(new Timestamp(System.currentTimeMillis()));
		empresa.setTipoEmpresaByIdTipoEmpresa(getTipoEmpresa(2));

		empresa.setEmpresaCategoriaByIdCategoriaEmpresa(
				getEmpresaCategoria(empresa.getIdEmpresaCategoria()));
		empresa.setEmpresaCategoriaTamanoByIdCategoriaTamanoEmpresa(
				getEmpresaCategoriaTamano(empresa.getIdEmpresaCategoriaTamano())
		);
		if(empresaOld != null){ // EXISTE
			empresa.setIdEmpresa(empresaOld.getIdEmpresa());
			empresa.setEstado(empresaOld.getEstado());
			empresa.setFechaCreacion(empresaOld.getFechaCreacion());
			getHibernateTemplate().update(empresa);
		} else {
			empresa.setEstado(false);
			getHibernateTemplate().save(empresa);

		}
		return 1;
	}

	public int saveEmpleado(Empleado empleado){
		return (Integer) getHibernateTemplate().save(empleado);
	}

	public Empresa getEmpresa(int id){
		return (Empresa) getHibernateTemplate().get(Empresa.class, id);
	}

	public Empresa getEmpresaFromNit(String nit){
		List<Empresa> empresas =
				getHibernateTemplate().find("from Empresa where nit = ?",
						nit);
		if(empresas.size()>0){
			return empresas.get(0);
		} else {
			return null;
		}
	}

	public Persona getPersona(int id){
		return (Persona) getHibernateTemplate().get(Persona.class, id);
	}

	public Persona getPersonaFromDoc(String doc){
		List<Persona> personas =
				getHibernateTemplate().find("from Persona where documentoIdentidad = ?",
						doc);
		if(personas.size()>0){
			return personas.get(0);
		} else {
			return null;
		}
	}

	public EmpresaCategoria getEmpresaCategoria(int id){
		return (EmpresaCategoria) getHibernateTemplate().get(EmpresaCategoria.class, id);
	}

	public EmpresaCategoriaTamano getEmpresaCategoriaTamano(int idEmpresaCategoriaTamano){
		return (EmpresaCategoriaTamano) getHibernateTemplate().get(EmpresaCategoriaTamano.class, idEmpresaCategoriaTamano);
	}

	public LocCiudad getCiudad(int id){
		return (LocCiudad) getHibernateTemplate().get(LocCiudad.class, id);
	}

	public CargoEmpleado getCargoEmpleado(int id){
		return (CargoEmpleado) getHibernateTemplate().get(CargoEmpleado.class, id);
	}

	public TipoEmpresa getTipoEmpresa(int id){
		return (TipoEmpresa) getHibernateTemplate().get(TipoEmpresa.class, id);
	}

	public int savePersona(Persona persona){
		Persona personaOld = getPersonaFromDoc(persona.getDocumentoIdentidad());

		persona.setLocCiudadByIdCiudad(getCiudad(persona.getLocCiudadPersona()));
		persona.setFechaCreacion(new Timestamp(System.currentTimeMillis()));
		if(personaOld != null){ // EXISTE
			persona.setIdPersona(personaOld.getIdPersona());
			persona.setEstado(personaOld.getEstado());
			persona.setFechaCreacion(personaOld.getFechaCreacion());
            persona.setPassword(personaOld.getPassword());
            persona.setAspiranteEvaluador(personaOld.getAspiranteEvaluador());
			getHibernateTemplate().update(persona);
		} else {
			persona.setEstado(false);
			/*int idPersona = (Integer) */
			getHibernateTemplate().saveOrUpdate(persona);
//            persona.setIdPersona(idPersona);
		}
		return 1;
	}

    public boolean isAdministrador(int idPersona){
        List<Empleado> empleados = getHibernateTemplate().find(
                "from Empleado where personaByIdPersona.idPersona = ? and perfilByIdPerfil.id = 1",
                idPersona
        );
        return empleados.size()>0;
    }

    /**
     * Selecciona tipo de premio
     * @param id tipo de premio
     * @return El objeto, o NULL
     */
    public PnTipoPremio selTipoPremio(int id){
        try {
            PnTipoPremio tipoPremio = getPnTipoPremio(id);
            WebContext wctx = WebContextFactory.get();
            HttpSession session = wctx.getSession(true);
            session.setAttribute("tipoPremio", tipoPremio);
            return tipoPremio;
        } catch (Exception e) {
            logger.debug(e.getMessage());
            return null;
        }
    }

    public PnTipoPremio getPnTipoPremio(int id){
        return (PnTipoPremio) getHibernateTemplate().get(PnTipoPremio.class, id);
    }

    public PnTipoPremio getPnTipoPremioFromSigla(String sigla){
        List<PnTipoPremio> tipoPremios;

        DetachedCriteria criteria;
        criteria = DetachedCriteria.forClass(PnTipoPremio.class);
        criteria.add(Restrictions.ilike("sigla", sigla, MatchMode.ANYWHERE));
        tipoPremios = getHibernateTemplate().findByCriteria(criteria);

        if(tipoPremios.size()>0){
            return tipoPremios.get(0);
        } else {
            return null;
        }

    }

    public Empleado selEmpleo(int id){
        try {
            Empleado empleado = getEmpleado(id);
            WebContext wctx = WebContextFactory.get();
            HttpSession session = wctx.getSession(true);
            Empleado empleadoOld = (Empleado) session.getAttribute("empleo");
            if(empleadoOld != null){
                logger.debug("empleadoOld.getPerfilByIdPerfil() = " + empleadoOld.getPerfilByIdPerfil());
            } else {
                logger.debug("No habia empleo en session");
            }
            session.setAttribute("empleo", empleado);
            return empleado;
        } catch (Exception e) {
            logger.debug(e.getMessage());
            return null;
        }
    }

    public void notificaEvaluadorAspiranteRegitro(Persona aspirante,
                                                  PnTipoPremio tipoPremio){
        String asunto = "Registro de Aspirante";
        String mensaje =
                "Cordial saludo" +
                        "<br>" +
                        "<br>" +
                        "Le informamos que hemos recibido su solicitud como Aspirante a Evaluador del " +
                        tipoPremio.getNombreTipoPremio() +
                        "<br>" +
                        "Estamos evaluando su solicitud, en breve le comunicaremos que pasos seguir." +
                        "<br>" +
                        "";
        String[] emails = {aspirante.getEmailPersonal()};
        enviaEmail(emails, asunto, mensaje, null, SUSCRIBE);
    }

    public int registroAspirante(Persona personaAspirante){
        logger.debug("aspirante.getNombre = " + personaAspirante.getNombrePersona());
        logger.debug("aspirante.getApellido() = " + personaAspirante.getApellido());
        WebContext wctx = WebContextFactory.get();
        HttpSession session = wctx.getSession(true);
        PnTipoPremio tipoPremio = (PnTipoPremio) session.getAttribute("tipoPremio");

        try {
            Persona aspiranteOld = getPersonaFromDoc(personaAspirante.getDocumentoIdentidad());
            if(aspiranteOld != null){
                personaAspirante = aspiranteOld;
            } else { // NO EXISTE
                personaAspirante.setEstado(false);
                personaAspirante.setLocCiudadByIdCiudad(getCiudad(0));
                personaAspirante.setFechaCreacion(new Timestamp(System.currentTimeMillis()));
                personaAspirante.setAspiranteEvaluador(1);
                int idPersonaAspirante = (Integer) getHibernateTemplate().save(personaAspirante);
                personaAspirante.setIdPersona(idPersonaAspirante);
            }

            PnAspiranteEvaluador aspiranteEvaluador = new PnAspiranteEvaluador();

            aspiranteEvaluador.setPersonaByIdPersona(personaAspirante);
            aspiranteEvaluador.setTipoPremioById(tipoPremio);
            aspiranteEvaluador.setPnPremioByIdConvocatoria(getPnPremioActivo(tipoPremio));
            aspiranteEvaluador.setFechaRegistro(new Timestamp(System.currentTimeMillis()));

            int idAspirante = (Integer) getHibernateTemplate().save(aspiranteEvaluador);

            notificaEvaluadorAspiranteRegitro(personaAspirante, tipoPremio);
            return 1;
        } catch (DataAccessException e) {

            logger.debug(e.getMessage());
            return 0;
        }
    }

    public PnEtapaParticipante getPnEtapaParticipante(int id){
        return (PnEtapaParticipante) getHibernateTemplate().get(PnEtapaParticipante.class, id);
    }

    public int cambiaP(int id,
                       String p){
        WebContext wctx = WebContextFactory.get();
        HttpSession session = wctx.getSession(true);
        Persona persona = (Persona) session.getAttribute("persona");
        if(persona == null){
            return 0;
        }
        try {
            if (id != 0) { // ADMIN
                persona = getPersona(id);
            } else {  // PERSONA
                persona = getPersona(persona.getIdPersona());
            }
            persona.setPassword(getMD5(p));
            getHibernateTemplate().update(persona);
            return 1;
        } catch (DataAccessException e) {
            e.printStackTrace();
            logger.debug(e.getMessage());
            return 0;
        }
    }

	public int saveInscrito(Empresa empresa,
							Persona personaDirectivo,
							Persona personaEncargado){
        System.out.println("Buenasss");

		WebContext wctx = WebContextFactory.get();
        HttpSession session = wctx.getSession(true);
        PnTipoPremio tipoPremio = (PnTipoPremio) session.getAttribute("tipoPremio");
		ServletContext context = wctx.getServletContext();

		logger.debug("empresa.getNit() = " + empresa.getNit());
		logger.debug("empresa.getNombreEmpresa() = " + empresa.getNombreEmpresa());
		logger.debug("empresa.getPublicaEmpresa() = " + empresa.getPublicaEmpresa());
		logger.debug("empresa.getIdEmpresaCategoriaTamano() = " + empresa.getIdEmpresaCategoriaTamano());
		empresa.setLocCiudadByIdCiudad(getCiudad(empresa.getLocCiudadEmpresa()));
		logger.debug("empresa.getLocCiudadByIdCiudad().getNombreCiudad() = " + empresa.getLocCiudadByIdCiudad().getNombreCiudad());
		logger.debug("empresa.getMarcas() = " + empresa.getMarcas());

		try {
			EmpresaCategoria categoriaEmpresa = getEmpresaCategoria(empresa.getIdEmpresaCategoria());
			logger.debug("categoriaEmpresa.getCategoria() = " + categoriaEmpresa.getCategoria());
			EmpresaCategoriaTamano empresaCategoriaTamano = getEmpresaCategoriaTamano(empresa.getIdEmpresaCategoriaTamano());
			logger.debug("empresaCategoriaTamano.getTamano() = " + empresaCategoriaTamano.getTamano());

			logger.debug("empresa.getFileCertificadoConstitucion() = " + empresa.getFileCertificadoConstitucion());
			logger.debug("empresa.getFileConsignacion() = " + empresa.getFileConsignacion());
			logger.debug("empresa.getFileEstadoFinancieroFile() = " + empresa.getFileEstadoFinancieroFile());

			/*  DIRECTIVO  */

			Persona directivoOld = getPersonaFromDoc(personaDirectivo.getDocumentoIdentidad());
			if(directivoOld != null){  // SI EXISTE
				personaDirectivo = directivoOld;
			} else { // NO EXISTE
				personaDirectivo.setEstado(false);
				personaDirectivo.setEmailPersonal(personaDirectivo.getEmailCorporativo());
				personaDirectivo.setLocCiudadByIdCiudad(empresa.getLocCiudadByIdCiudad());
				personaDirectivo.setFechaCreacion(new Timestamp(System.currentTimeMillis()));
				int idDirectivo = (Integer) getHibernateTemplate().save(personaDirectivo);
				personaDirectivo.setIdPersona(idDirectivo);
			}

			logger.debug("personaDirectivo.getIdPersona() = " 			+ personaDirectivo.getIdPersona());
			logger.debug("personaDirectivo.getDocumentoIdentidad() = " 	+ personaDirectivo.getDocumentoIdentidad());
			logger.debug("personaDirectivo.getNombrePersona() = " 		+ personaDirectivo.getNombrePersona());
			logger.debug("personaDirectivo.getApellido() = " 			+ personaDirectivo.getApellido());

			/*  EMPLEADO  */

			Persona empleadoOld = getPersonaFromDoc(personaEncargado.getDocumentoIdentidad());
			if(empleadoOld != null){       // SI EXISTE EN LA DB
				// PARA QUE NO SE PIERDA EL CARGO LO TRAIGO DEL FORM
				empleadoOld.setIdCargoEmpleado(personaEncargado.getIdCargoEmpleado());
				personaEncargado = empleadoOld;
			} else {
				personaEncargado.setEstado(false);
				personaEncargado.setLocCiudadByIdCiudad(empresa.getLocCiudadByIdCiudad());
				personaEncargado.setFechaCreacion(new Timestamp(System.currentTimeMillis()));
				int idEmpleado = (Integer) getHibernateTemplate().save(personaEncargado);
				personaEncargado.setIdPersona(idEmpleado);
			}

			logger.debug("personaEncargado.getIdPersona() = " + personaEncargado.getIdPersona());
			logger.debug("personaEncargado.getDocumentoIdentidad() = " + personaEncargado.getDocumentoIdentidad());
			logger.debug("personaEncargado.getNombrePersona() = "	 	+ personaEncargado.getNombrePersona());
			logger.debug("personaEncargado.getIdCargoEmpleado() = " 	+ personaEncargado.getIdCargoEmpleado());

			/*  EMPRESA  */

			Empresa empresaOld = getEmpresaFromNit(empresa.getNit());
			if(empresaOld != null){
				empresa = empresaOld;
			} else {
				empresa.setFechaCreacion(new Timestamp(System.currentTimeMillis()));
				empresa.setTipoEmpresaByIdTipoEmpresa(getTipoEmpresa(2));
				empresa.setEstado(false); // sin aprovar
				empresa.setEmpresaCategoriaByIdCategoriaEmpresa(categoriaEmpresa);
				empresa.setEmpresaCategoriaTamanoByIdCategoriaTamanoEmpresa(empresaCategoriaTamano);

				String path = context.getRealPath("/pdfs");
//				System.out.println("path = " + path);

				/*
				String fileInformePostulacion  		= path+"/ip-"+empresa.getNit()+".pdf";
				String fileCertificadoConstitucion  = path+"/cc-"+empresa.getNit()+".pdf";
				String fileEstadoFinanciero         = path+"/ef-"+empresa.getNit()+".pdf";
				String fileConsignacion             = path+"/co-"+empresa.getNit()+".pdf";
				try {
					FileOutputStream informePostulacionStream = new FileOutputStream(fileInformePostulacion);
					logger.debug("empresa.getFileInformePostulacionFile() = " + empresa.getFileInformePostulacionFile());
					informePostulacionStream.write(empresa.getFileInformePostulacionFile());
					informePostulacionStream.close();

					FileOutputStream certificadoConstitucionStream = new FileOutputStream(fileCertificadoConstitucion);
					certificadoConstitucionStream.write(empresa.getFileCertificadoConstitucionFile());
					certificadoConstitucionStream.close();

					FileOutputStream estadoFinancieroStream = new FileOutputStream(fileEstadoFinanciero);
					estadoFinancieroStream.write(empresa.getFileEstadoFinancieroFile());
					estadoFinancieroStream.close();

					FileOutputStream consignacionStream = new FileOutputStream(fileConsignacion);
					consignacionStream.write(empresa.getFileConsignacionFile());
					consignacionStream.close();

				} catch (FileNotFoundException e) {
					e.printStackTrace();
					logger.debug(e.getMessage());
					return 0;
				} catch (IOException e) {
					e.printStackTrace();
					logger.debug(e.getMessage());
					return 0;
				}

				empresa.setFileInformePostulacion(fileInformePostulacion);
				empresa.setFileCertificadoConstitucion(fileCertificadoConstitucion);
				empresa.setFileEstadoFinanciero(fileEstadoFinanciero);
				empresa.setFileConsignacion(fileConsignacion);
*/
				logger.debug("est 1");

				int idEmpresa = (Integer) saveEmpresa(empresa);
				empresa.setIdEmpresa(idEmpresa);
			}

			// TODO PONER LOS PDF EN EL PARTICIPANTE

			/*  PARTICIPANTE  */
			Participante participante = new Participante();
			participante.setFechaIngreso(new Timestamp(System.currentTimeMillis()));
			participante.setEstado(false); // HAY QUE ACTIVARLO
			participante.setObservaciones("Registro Web");
			participante.setEmpresaByIdEmpresa(empresa);
			participante.setPnPremioByIdConvocatoria(getPnPremioActivo(tipoPremio));
			participante.setPnEtapaParticipanteByIdEtapaParticipante(
					getPnEtapaParticipante(1));

			int idParticipante = (Integer) getHibernateTemplate().save(participante);
			logger.debug("idParticipante = " + idParticipante);
			participante.setIdParticipante(idParticipante);


			// VINCULAR PERSONAL

			/*  ENCARGADO  */
			Empleado empleadoEncargado = new Empleado();
			empleadoEncargado.setFechaIngreso(new Timestamp(System.currentTimeMillis()));
			empleadoEncargado.setParticipanteByIdParticipante(participante);
			logger.debug("personaEncargado.getIdCargoEmpleado() = " + personaEncargado.getIdCargoEmpleado());
			CargoEmpleado cargoEncargado = getCargoEmpleado(personaEncargado.getIdCargoEmpleado());
			logger.debug("cargoEncargado.getCargo() = " + cargoEncargado.getCargo());
			empleadoEncargado.setCargoEmpleadoByIdCargo(cargoEncargado);
			empleadoEncargado.setPerfilByIdPerfil(getPerfil(3)); // Encargado de Proceso
			empleadoEncargado.setPersonaByIdPersona(personaEncargado);

			Integer idEncargado = (Integer) getHibernateTemplate().save(empleadoEncargado);
			if(idEncargado != null){
				notificaEmpleadoVinculo(empleadoEncargado);
			}
			empleadoEncargado.setIdEmpleado(idEncargado);

			/*  DIRECTIVO  */
			Empleado empleadoDirectivo = new Empleado();
			empleadoDirectivo.setFechaIngreso(new Timestamp(System.currentTimeMillis()));
			empleadoDirectivo.setParticipanteByIdParticipante(participante);
			empleadoDirectivo.setCargoEmpleadoByIdCargo(getCargoEmpleado(4)); //TODO PERGUNTAR EN EL FORM REGISTRO POR ESTE CARGO
			empleadoDirectivo.setPerfilByIdPerfil(getPerfil(5)); // Encargado de Proceso
			empleadoDirectivo.setPersonaByIdPersona(personaDirectivo);

			Integer idDirectivo = (Integer) getHibernateTemplate().save(empleadoDirectivo);
			if(idDirectivo != null){
				notificaEmpleadoVinculo(empleadoDirectivo);
			}
			empleadoDirectivo.setIdEmpleado(idDirectivo);


			return 1;
		} catch (DataAccessException e) {
			logger.debug("e.getMessage() = " + e.getMessage());
			e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
			return 0;
		}
	} /*  FIN INSCRIPCION  */

    public int subeArchivoPostula(byte[] fileInformePostulacionFile){
//        logger.debug("fileInformePostulacionFile = " + fileInformePostulacionFile);

        WebContext wctx = WebContextFactory.get();
        HttpSession session = wctx.getSession(true);
        final Empleado empleado = (Empleado) session.getAttribute("empleo");

        if (empleado != null) {
            ServletContext context = wctx.getServletContext();
            String path = context.getRealPath("/pdfs");
            Empresa empresa = empleado.getParticipanteByIdParticipante().getEmpresaByIdEmpresa();
            String fileName = "ip-" + empresa.getNit() +"-"+empleado.getParticipanteByIdParticipante().getIdParticipante()+ ".pdf";
            String fileInformePostulacion  		= path + "/" + fileName;

            try {
                FileOutputStream outputStream = new FileOutputStream(fileInformePostulacion);
//                logger.debug("empresa.getFileInformePostulacionFile() = " + empresa.getFileInformePostulacionFile());
                outputStream.write(fileInformePostulacionFile);
                outputStream.close();

                Participante participante = getParticipante(empleado.getParticipanteByIdParticipante().getIdParticipante());
                participante.setFileInformePostula(fileName);
                getHibernateTemplate().update(participante);

                return 1;
            } catch (IOException e) {
                e.printStackTrace();
                logger.debug(e.getMessage());
                return 0;
            }
        }
        return 0;
    }
    public int subeArchivoConsigna(byte[] fileConsignacionFile){

        WebContext wctx = WebContextFactory.get();
        HttpSession session = wctx.getSession(true);
        final Empleado empleado = (Empleado) session.getAttribute("empleo");

        if (empleado != null) {
            ServletContext context = wctx.getServletContext();
            String path = context.getRealPath("/pdfs");
            Empresa empresa = empleado.getParticipanteByIdParticipante().getEmpresaByIdEmpresa();
            String fileName = "co-" + empresa.getNit() +"-"+empleado.getParticipanteByIdParticipante().getIdParticipante()+ ".pdf";
            String filePath  		= path + "/" + fileName;

            try {
                FileOutputStream outputStream = new FileOutputStream(filePath);
//                logger.debug("empresa.getFileInformePostulacionFile() = " + empresa.getFileInformePostulacionFile());
                outputStream.write(fileConsignacionFile);
                outputStream.close();

                Participante participante = getParticipante(empleado.getParticipanteByIdParticipante().getIdParticipante());
                participante.setFileConsignacion(fileName);
                getHibernateTemplate().update(participante);

                return 1;
            } catch (IOException e) {
                e.printStackTrace();
                logger.debug(e.getMessage());
                return 0;
            }
        }
        return 0;
    }

    public int subeArchivoCLegal(byte[] fileCertificadoConstitucionFile){
        WebContext wctx = WebContextFactory.get();
        HttpSession session = wctx.getSession(true);
        final Empleado empleado = (Empleado) session.getAttribute("empleo");

        if (empleado != null) {
            ServletContext context = wctx.getServletContext();
            String path = context.getRealPath("/pdfs");
            Empresa empresa = empleado.getParticipanteByIdParticipante().getEmpresaByIdEmpresa();
            String fileName = "cc-" + empresa.getNit() + ".pdf";
            String filePath  		= path + "/" + fileName;

            try {
                FileOutputStream outputStream = new FileOutputStream(filePath);
//                logger.debug("empresa.getFileInformePostulacionFile() = " + empresa.getFileInformePostulacionFile());
                outputStream.write(fileCertificadoConstitucionFile);
                outputStream.close();

                empresa = getEmpresa(empresa.getIdEmpresa());
                empresa.setFileCertificadoConstitucion(fileName);
                getHibernateTemplate().update(empresa);

                return 1;
            } catch (IOException e) {
                e.printStackTrace();
                logger.debug(e.getMessage());
                return 0;
            }
        }
        return 0;
    }

    public int subeArchivoFinanciero(byte[] getFileEstadoFinancieroFile){
        WebContext wctx = WebContextFactory.get();
        HttpSession session = wctx.getSession(true);
        final Empleado empleado = (Empleado) session.getAttribute("empleo");

        if (empleado != null) {
            ServletContext context = wctx.getServletContext();
            String path = context.getRealPath("/pdfs");
            Empresa empresa = empleado.getParticipanteByIdParticipante().getEmpresaByIdEmpresa();
            String fileName = "ef-" + empresa.getNit() + ".pdf";
            String filePath  		= path + "/" + fileName;

            try {
                FileOutputStream outputStream = new FileOutputStream(filePath);
//                logger.debug("empresa.getFileInformePostulacionFile() = " + empresa.getFileInformePostulacionFile());
                outputStream.write(getFileEstadoFinancieroFile);
                outputStream.close();

                empresa = getEmpresa(empresa.getIdEmpresa());
                empresa.setFileEstadoFinanciero(fileName);
                getHibernateTemplate().update(empresa);

                return 1;
            } catch (IOException e) {
                e.printStackTrace();
                logger.debug(e.getMessage());
                return 0;
            }
        }
        return 0;
    }

	public Perfil getPerfil(int id){
		return (Perfil) getHibernateTemplate().get(Perfil.class, id);
	}

	public List<Persona> getPersonas(){
		return getHibernateTemplate().find(
				"from Persona order by nombrePersona , apellido "
		);
	}

	public List<PnPremio> getPnPremios(PnTipoPremio tipoPremio){
		return getHibernateTemplate().find("from PnPremio where idPnPremio > 1 and " +
                " tipoPremioById.id = ? ",
                tipoPremio.getId());
	}

	/**
	 * Solo los Activos para Inscripcion
	 * @return
	 */
	public List<PnPremio> getPnPremiosActivos(){
		return getHibernateTemplate().find("from PnPremio where estadoInscripcion = true");
	}

	public PnPremio getPnPremio(int id){
		PnPremio premio = (PnPremio) getHibernateTemplate().get(PnPremio.class, id);
		return premio;
	}

	public Participante getParticipante(int idParticipante){
		return (Participante) getHibernateTemplate().get(Participante.class, idParticipante);
	}

	public Participante vinculeParticipantePremio(int idPremio,
												  int idEmpresa){
		try {
			Participante participante = new Participante();
			participante.setFechaIngreso(new Timestamp(System.currentTimeMillis()));
			participante.setEstado(false); // HAY QUE ACTIVARLO
			participante.setObservaciones("Registro Interno");
			participante.setEmpresaByIdEmpresa(getEmpresa(idEmpresa));
			participante.setPnPremioByIdConvocatoria(getPnPremio(idPremio));
            participante.setPnEtapaParticipanteByIdEtapaParticipante(
                getPnEtapaParticipante(1));
			int idParticipante = (Integer) getHibernateTemplate().save(participante);
			participante.setIdParticipante(idParticipante);

			return participante;
		} catch (DataAccessException e) {
			logger.debug(e.getMessage());
			return null;
		}
	}

	public Boolean activeDesactiveParticipante(int idParticipante){
		try {
			Participante participante = getParticipante(idParticipante);
			participante.setEstado(!participante.getEstado());
			getHibernateTemplate().update(participante);
			return participante.getEstado();
		} catch (DataAccessException e) {
			logger.debug(e.getMessage());
			return null;
		}
	}

	public Boolean activeDesactiveEmpresa(final int idEmpresa){
		try {
			Empresa empresa = getEmpresa(idEmpresa);
			empresa.setEstado(!empresa.getEstado());
			getHibernateTemplate().update(empresa);
			return empresa.getEstado();
		} catch (DataAccessException e) {
			logger.debug(e.getMessage());
			return null;
		}
	}

	public int hayPnPremiosActivos(int idTipoPremio){
		List<PnPremio> premios = getHibernateTemplate().find(
				"from PnPremio where estadoInscripcion = true and tipoPremioById.id=?",
                idTipoPremio
		);
		if (premios.size()>0){
			return premios.get(0).getIdPnPremio();
		} else {
			return 0;
		}
	}

	/**
	 * Retorna el Premio activo Segun su Tipo o Categoria. Solo puede haber uno
	 * @return p
	 */
	public PnPremio getPnPremioActivo(PnTipoPremio tipoPremio){
		List<PnPremio> premios = getHibernateTemplate().find(
				"from PnPremio where estadoInscripcion = true and tipoPremioById.id=?",
                tipoPremio.getId()
		);
		if (premios.size()>0){
			return premios.get(0);
		} else {
			return null;
		}
	}

	public int activeDesactivePremioN(int idPremio,
                                      int idTipoPremio){
		try {
			int hay = hayPnPremiosActivos(idTipoPremio);
			if(hay >0 && hay !=idPremio){ // No hay mas Premios Activos y no es el mismo
				return 2;
			} else {
				PnPremio premio = getPnPremio(idPremio);
				premio.setEstadoInscripcion(!premio.getEstadoInscripcion());
				getHibernateTemplate().update(premio);
				if(premio.getEstadoInscripcion()){
					return 1;
				} else {
					return 0;
				}
			}
		} catch (DataAccessException e) {
			e.printStackTrace();
			return 3;
		}
	}

	public Boolean activeDesactivePersona(int idPersona){
		try {
			Persona persona = getPersona(idPersona);
			persona.setEstado(!persona.getEstado());
			getHibernateTemplate().update(persona);
			return persona.getEstado();
		} catch (DataAccessException e) {
			logger.debug(e.getMessage());
			return null;
		}
	}

    public int savePnTipoPremio(PnTipoPremio tipoPremio){
        WebContext wctx = WebContextFactory.get();
        HttpSession session = wctx.getSession(true);
        Persona persona = (Persona) session.getAttribute("persona");
        try {
            PnTipoPremio tipoPremioOld = getPnTipoPremio(tipoPremio.getId());
            tipoPremio.setPersonaById(persona);
            if(tipoPremioOld==null){
                tipoPremio.setFechaCreacion(new Timestamp(System.currentTimeMillis()));
                tipoPremio.setUrlLogo("");
                tipoPremio.setUrlLogoSmall("");
                tipoPremio.setBanner("");
            } else {
                tipoPremio.setUrlLogo(tipoPremioOld.getUrlLogo());
                tipoPremio.setUrlLogoSmall(tipoPremioOld.getUrlLogoSmall());
                tipoPremio.setBanner(tipoPremioOld.getBanner());
                tipoPremio.setFechaCreacion(tipoPremioOld.getFechaCreacion());
            }
            getHibernateTemplate().saveOrUpdate(tipoPremio);
            return 1;
        } catch (DataAccessException e) {
            logger.debug(e.getMessage());
            return 0;
        }
    }

	public int savePnPremio(PnPremio premio ){
        WebContext wctx = WebContextFactory.get();
        HttpSession session = wctx.getSession(true);
        PnTipoPremio tipoPremio = (PnTipoPremio) session.getAttribute("tipoPremio");
		logger.debug("Entro");
		logger.debug("premio.getIdPnPremio() = " + premio.getIdPnPremio());
        PnPremio pnPremioOld = getPnPremio(premio.getIdPnPremio());
        logger.debug("pnPremioOld = " + pnPremioOld);
        try {
            if (pnPremioOld==null) {  // NEW
                logger.debug("es nuevo");
                logger.debug("pnPremioOld = " + pnPremioOld);
                premio.setTipoPremioById(tipoPremio);
                premio.setFechaCreacion(new Timestamp(System.currentTimeMillis()));
                getHibernateTemplate().save(premio);
            } else { // es OLD
                premio.setTipoPremioById(pnPremioOld.getTipoPremioById());
                premio.setEstadoInscripcion(pnPremioOld.getEstadoInscripcion());
                premio.setFechaCreacion(pnPremioOld.getFechaCreacion());
                getHibernateTemplate().update(premio);
            }
//            premio.setFechaDesde(new Timestamp(df.parse(premio.getTmpFechaDesde()).getTime()));
//			premio.setFechaHasta(new Timestamp(df.parse(premio.getTmpFechaHasta()).getTime()));
//			getHibernateTemplate().saveOrUpdate(premio);
			return 1;
		} catch (DataAccessException e) {
			logger.debug(e.getMessage());
			return 0;
		} catch (Exception e) {
            e.printStackTrace();
			logger.debug(e.getMessage());
			return 0;
		}
	}

	public List<Empleado> getEmpleosFromPersona(int idPersona){
		List<Empleado> empleados = getHibernateTemplate().find(
				"from Empleado where personaByIdPersona.idPersona = ? order by participanteByIdParticipante.pnPremioByIdConvocatoria.fechaDesde desc ", 
                idPersona
		);
		logger.debug("empleados nro = " + empleados.size());
		return empleados;
	}

	public Persona getPersonaFromLoginPassword(String login,
											   String password){
		Object o[] = {
                login,
                getMD5(password)
        };
        List<Persona> personas =  getHibernateTemplate().find(
                "from Persona where emailPersonal = ? and password = ?",
                o);
        if(personas.size() == 0){
            return null;
        } else {
            return personas.get(0);
        }

	}

	public String getMD5(String yourString){
//        yourString = "123456789";
		byte[] bytesOfMessage = yourString.getBytes();

		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			byte[] thedigest = md.digest(bytesOfMessage);

			StringBuffer hexString = new StringBuffer();
			for (byte aThedigest : thedigest) {
				String hex = Integer.toHexString(0xff & aThedigest);
				if (hex.length() == 1) hexString.append('0');
				hexString.append(hex);
			}
			logger.debug("Digest(in hex format):: " + hexString.toString());
			return hexString.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return "";
		}
	}


	/*****************************************************************************************/
	/*****************************************************************************************/
	/*********************    CORREO ELECTRONICO EMAIL  **************************************/
	/*****************************************************************************************/
	/*****************************************************************************************/

	public static final int SUSCRIBE = 1;
	public static final int INFO = 2;

	private String SMTP_HOST_NAME = "smtp.gmail.com";
	private String SMTP_PORT = "465";
	private String emailMsgTxt = "Test Message Contents";
	private String emailSubjectTxt = "A test from gmail";
	//    private String emailFromAddress = "fucdigital_1@clcgas.com.co";
	private String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
	private String[] sendTo = {"edward_ramirez_pc@yahoo.com.ar", "elramireza@gmail.com"};



	String email[][] = {
			{"", ""},
			{"premiogestion@gmail.com", "corca*123", "Mensajes C.Calidad"},
			{  "", ""},
			{"5", "6"}
	};



	public void testEmail(int desde){
		enviaEmail(sendTo, emailSubjectTxt,
				emailMsgTxt, new File[0], desde);
	}


	/**
	 * envia email
	 * @param recipients para quien
	 * @param subject s
	 * @param message  msg
	 * @param attachments array de java.io.File
	 * @param emailDesde 1 SUSCRIBE  ... 2 INFO
	 * @return  1 si bien  0 si error
	 */
	public int enviaEmail(String recipients[],
						  String subject,
						  String message,
						  File[] attachments,
						  int emailDesde){

		int ret=1;

		String desde = 			email[emailDesde][0];
		String desdeNombre = 	email[emailDesde][2];
		logger.debug("desde = " + desde);
		logger.debug("desdeNombre = " + desdeNombre);
		String passwd = email[emailDesde][1];
//        logger.debug("passwd = " + passwd);

		boolean debug = false;

//        Properties props = getPropertiesEmail();

		try {
			javax.mail.Session session = null;

			switch (emailDesde){
				case SUSCRIBE:
					session = getSessionSuscribe();
					break;
				case INFO:
					session = getSessionInfo();
			}
			if (session != null) {
				session.setDebug(debug);
			}

//            Message msg = new MimeMessage(session);

//            logger.debug("session.getPasswordAuthentication().getUserName() = " + session.getPasswordAuthentication().getUserName());

			MimeMessage msg = new MimeMessage(session);

// crear las partes del mensaje
			MimeBodyPart messageBodyPart = new MimeBodyPart();

			//Llenar la parte del mensaje
			messageBodyPart.setText(message, "UTF-8", "html");

			InternetAddress addressFrom = null;
			try {
				addressFrom = new InternetAddress(desde, desdeNombre);
			} catch (UnsupportedEncodingException e) {
				addressFrom = new InternetAddress(desde);
			}
			msg.setFrom(addressFrom);

			Multipart multipart = new MimeMultipart();
			multipart.addBodyPart(messageBodyPart);


// Archivos

//            String urlArchivo = archivosDAO.getUrlFolder() + "/e/master.pdf";


/// adicion de archivos

			if (attachments != null) {
				for (File attachment : attachments) {
					logger.debug("attachment.getName() = " + attachment.getName());
					logger.debug("attachment.length() = " + attachment.length());
					messageBodyPart = new MimeBodyPart();
					FileDataSource fileDataSource = new FileDataSource(attachment);
					messageBodyPart.setDataHandler(new DataHandler(fileDataSource));
					messageBodyPart.setFileName(attachment.getName());
					multipart.addBodyPart(messageBodyPart);
				}
			}

			msg.setContent(multipart);


			InternetAddress[] addressTo = new InternetAddress[recipients.length];
			for (int i = 0; i < recipients.length; i++) {
				addressTo[i] = new InternetAddress(recipients[i]);
//                logger.debug("recipients[i] = " + recipients[i]);
			}
			msg.setRecipients(Message.RecipientType.TO, addressTo);

// Setting the Subject and Content Type
			msg.setSubject(subject + " " + dfDateTime.format(new Date()));
//            msg.setContent(date.toString(), "text/plain");
//            msg.setText(date.toString());

			Transport.send(msg);
		} catch (MessagingException e) {
			e.printStackTrace();
			logger.debug(e.getMessage());
			ret = 0;
		} catch (Exception e){
			e.printStackTrace();
		}

		return ret;
	}


	static javax.mail.Session sessionSuscribe = null;
	static javax.mail.Session sessionInfo = null;

	public javax.mail.Session getSessionSuscribe(){
//        logger.debug("entro a: getSessionSuscribe");
		try {
			if (sessionSuscribe == null) {
				logger.debug("sessionSuscribe SI null");
				sessionSuscribe =      javax.mail.Session.getInstance(getPropertiesEmail(),
						new Authenticator() {

							protected PasswordAuthentication getPasswordAuthentication() {
								//                            return new PasswordAuthentication(emailFromAddress, "clcgas2010");

								return new PasswordAuthentication(email[SUSCRIBE][0], email[SUSCRIBE][1]);
							}
						});
			} else {
				logger.debug("sessionSuscribe NO null");
			}
		} catch (Exception e) {
			e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
		}
		return sessionSuscribe;
	}

	public javax.mail.Session getSessionInfo(){
//        logger.debug("entro a: getSessionInfo");
		if (sessionInfo == null) {
			logger.debug("sessionInfo SI null");
			sessionInfo =    javax.mail.Session.getInstance(getPropertiesEmail(),
					new Authenticator() {
						protected PasswordAuthentication getPasswordAuthentication() {
							return new PasswordAuthentication(email[INFO][0], email[INFO][1]);
						}
					});
		} else {
			logger.debug("sessionInfo NO null");
		}
		return sessionInfo;
	}


	public Properties getPropertiesEmail(){
		Properties props;
		props = new Properties();
		props.put("mail.smtp.host", SMTP_HOST_NAME);
		props.put("mail.smtp.socketFactory.port", SMTP_PORT);
		props.put("mail.smtp.socketFactory.class", SSL_FACTORY);
		props.put("mail.smtp.auth", "true");
		props.put("mail.debug", "true");
		props.put("mail.smtp.port", SMTP_PORT);
		props.put("mail.smtp.socketFactory.fallback", "false");
		return props;
	}



	/*****************************************************************************************/
	/*****************************************************************************************/
	/*********************    PASSWORD GENERATRO EMAIL  **************************************/
	/*****************************************************************************************/
	/*****************************************************************************************/

	public static final char[] HEX_CHARS = { 'a','b','c','d','e','f','g','h','0','1','2','3','4','5','6','7','8','9' };
	public static final char[] SECURE_CHARS = { 'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u',
			'v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',
			'Q','R','S','T','U','V','W','X','Y','Z','0','1','2','3','4','5','6','7','8','9','=',
			'!','$','#','+','%','&','/','(',')','[',']' };
	public static final int largePass = 9;

	public String getRandomPassword(){
		String s = "";

		Random generator = new Random();
		int r;

		int i=0;
		while (i<largePass) {
			r = Math.abs(generator.nextInt());
			logger.debug("r = " + r);
			while (r > SECURE_CHARS.length-1) {
				r = r/2;
//                logger.debug("r int = " + r);
			}
			s += SECURE_CHARS[r];
//            logger.debug("s.le = " + s.length());
//            logger.debug("i = " + i+"\tr = " + r + "\t s:"+s);
			i++;
		}

		return s;
	}


	public String getIncludeResultadoInd(int idEmpleado,
										 String page,
										 int nombre){
		logger.debug("idEmpleado = " + idEmpleado);
		logger.debug("page = " + page);
		logger.debug("nombre = " + nombre);
		WebContext wctx = WebContextFactory.get();
		String url = format("/r_%s.jsp", page);
		logger.debug("url = " + url);

		Texto texto = getTexto(nombre);

		wctx.getHttpServletRequest().setAttribute("nombre", texto);
		wctx.getHttpServletRequest().setAttribute("id", idEmpleado);
		String respuesta = "";
		try {
			respuesta = wctx.forwardToString(url);
		} catch (ServletException e) {
			e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
		} catch (IOException e) {
			e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
		}
		return respuesta;
	}

    public String getIncludeResultadoConsenso(int idParticipante,
                                              String page,
                                              int nombre){
        logger.debug("idParticipante = " + idParticipante);
        logger.debug("page = " + page);
        logger.debug("nombre = " + nombre);
        WebContext wctx = WebContextFactory.get();
        String url = format("/r_%s.jsp", page);
        logger.debug("url = " + url);

        Texto texto = getTexto(nombre);

        wctx.getHttpServletRequest().setAttribute("nombre", texto.getTexto2());
        wctx.getHttpServletRequest().setAttribute("id", idParticipante);
        String respuesta = "";
        try {
            respuesta = wctx.forwardToString(url);
        } catch (ServletException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        } catch (IOException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        return respuesta;
    }

    public int enviarAgenda(int idParticipante){
        try {
            Participante participante = getParticipante(idParticipante);
            List<Empleado> empleados = getEmpleadosFromParticipante(idParticipante);
            PnAgenda agenda = getPnAgendaFromParticipante(idParticipante);
            List<PnAgendaInvitado> invitados = getPnAgendaInvitadosFromParticipante(idParticipante);
            List<Empleado> evaluadores = getEvaluadoresFromParticipante(idParticipante);
            String mensaje = "";
            mensaje += "<h4>\n" +
                    "    Visita programada para:  " + dfNameMonth.format(agenda.getFechaAgenda());
            mensaje += "</h4>\n" +
                    "<br>\n" +
                    "<h5>\n" +
                    "    Evaluadores:\n" +
                    "</h5>\n" +
                    "<blockquote><ul  type = disc style=\"margin-left: 20px;\">";
            for (Empleado evaluador: evaluadores){
            mensaje += "<li style=\"text-transform: capitalize;\">" +evaluador.getPersonaByIdPersona().getNombreCompleto();
            mensaje += "</li>";
            }  //  END FOR EVALUADORES
            mensaje += "</ul></blockquote>\n" +
                    "<br>";

            mensaje += "<br> <h5>Agenda Planeada</h5>";
            mensaje += "<table cellpadding=\"0\" cellspacing=\"0\" border=\"1\"  id=\"invitados\" class=\"table table-hover table-striped\" >";
            mensaje += "";
            mensaje += "";
            mensaje += "<thead>\n" +
                    "    <tr>\n" +
                    "        <th>\n" +
                    "            Cargo o Persona\n" +
                    "        </th>\n" +
                    "        <th>\n" +
                    "            &Iacute;tem\n" +
                    "        </th>\n" +
                    "        <th>\n" +
                    "            Documentos Requeridos\n" +
                    "        </th>\n" +
                    "        <th>\n" +
                    "            Preguntas\n" +
                    "        </th>\n" +
                    "    </tr>\n" +
                    "    </thead>";
            mensaje += "";
            mensaje += "";
            for (PnAgendaInvitado invitado: invitados ) {
                mensaje += "<tr>\n" +
                        "        <td>" + invitado.getIdEmpleado();
                mensaje += "</td>\n" +
                        "        <td>" + invitado.getPnSubCapituloByIdPnSubcapitulo().getCodigoItem() + " " +
                        invitado.getPnSubCapituloByIdPnSubcapitulo().getSubCapitulo();
                mensaje += "</td>\n" +
                        "        <td>" + invitado.getDocumentos().replace("\n", "<br>");
                mensaje += "</td>\n" +
                        "        <td>" + invitado.getPreguntas().replace("\n", "<br>");
                mensaje += "</td>\n" +
                        "    </tr>";
            }  //  END FOR INVITADOS AGENDA
            mensaje += "</table>";
            mensaje += "";
            mensaje += "";
            mensaje += "";
            String sigla = participante.getPnPremioByIdConvocatoria().getTipoPremioById().getSigla();
            logger.debug("sigla = " + sigla);
            String version = participante.getPnPremioByIdConvocatoria().getVersion();
            logger.debug("version = " + version);

            //  TODOS LOS EMPLEADOS
            for (int i = 0; i < empleados.size(); i++) {
                Empleado empleado = empleados.get(i);
                String emailPersonal = empleado.getPersonaByIdPersona().getEmailPersonal();
                String[] emails = {emailPersonal};
                enviaEmail(
                        emails,
                        "Agenda de Visita "
                                + sigla
                                + " " + version,
                        mensaje,
                        null,
                        SUSCRIBE);
            }  //  END FOR EMPLEADOS






            return 1;
        } catch (Exception e) {
            return 0;
        }
    }

    public int responderPreguntasP(final String p1,
                                   final String p2,
                                   final String p3){

        WebContext wctx = WebContextFactory.get();
        HttpSession session = wctx.getSession(true);
        final Empleado empleado = (Empleado) session.getAttribute("empleo");
        final Participante participante = empleado.getParticipanteByIdParticipante();

        try {
            getHibernateTemplate().execute(new HibernateCallback() {
                @Override
                public Object doInHibernate(Session session) throws HibernateException, SQLException {
                    Query query = session.createQuery(
                            "update Participante set pregunta1=?, pregunta2=?, pregunta3=? where idParticipante=?"
                    );

                    query.setString(0, p1);
                    query.setString(1, p2);
                    query.setString(2, p3);
                    query.setInteger(3, participante.getIdParticipante());

                    query.executeUpdate();
                    return null;  //To change body of implemented methods use File | Settings | F
                }
            });
            return 1;
        } catch (DataAccessException e) {
            e.printStackTrace();
            logger.debug(e.getMessage());
            return 0;
        }
    }

    public static String txtToHtml(String s) {
        StringBuilder builder = new StringBuilder();
        boolean previousWasASpace = false;
        for (char c : s.toCharArray()) {
            if (c == ' ') {
                if (previousWasASpace) {
                    builder.append("&nbsp;");
                    previousWasASpace = false;
                    continue;
                }
                previousWasASpace = true;
            } else {
                previousWasASpace = false;
            }
            switch (c) {
                case '<':
                    builder.append("&lt;");
                    break;
                case '>':
                    builder.append("&gt;");
                    break;
                case '&':
                    builder.append("&amp;");
                    break;
                case '"':
                    builder.append("&quot;");
                    break;
                case '\n':
                    builder.append("<br>");
                    break;
                // We need Tab support here, because we print StackTraces as HTML
                case '\t':
                    builder.append("&nbsp; &nbsp; &nbsp;");
                    break;
                default:
                    builder.append(c);

            }
        }
        String converted = builder.toString();
        String str = "(?i)\\b((?:https?://|www\\d{0,3}[.]|[a-z0-9.\\-]+[.][a-z]{2,4}/)(?:[^\\s()<>]+|\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*\\))+(?:\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*\\)|[^\\s`!()\\[\\]{};:\'\".,<>?«»“”‘’]))";
        Pattern patt = Pattern.compile(str);
        Matcher matcher = patt.matcher(converted);
        converted = matcher.replaceAll("<a href=\"$1\">$1</a>");
        return converted;
    }
}