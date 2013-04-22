package co.com.elramireza.pn.dao;

import co.com.elramireza.pn.model.*;
import co.com.elramireza.pn.util.MyKey;
import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.directwebremoting.io.FileTransfer;
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
import java.awt.image.BufferedImage;
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
	public SimpleDateFormat dfDateTime = new SimpleDateFormat("dd/MM/yyyy KK:mm aaa");

	public String test(String s){
		logger.info("s = " + s);
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

    public int saveAgenda(String fechaS){
        try {
            WebContext wctx = WebContextFactory.get();
            HttpSession session = wctx.getSession(true);
            final Empleado empleado = (Empleado) session.getAttribute("empleo");

            Participante participanteByIdParticipante = empleado.getParticipanteByIdParticipante();
            //LO RECARGO PORQUE PUEDE ESTAR CAMBIANDO EN EL AIRE
            participanteByIdParticipante = getParticipante(participanteByIdParticipante.getIdParticipante());
            PnEtapaParticipante etapaParticipante = participanteByIdParticipante.getPnEtapaParticipanteByIdEtapaParticipante();
            if(etapaParticipante.getIdEtapaParticipante()!=3 ){ // AGENDA
                throw new SecurityException("No puede escribir datos. El Participante se encuentra en etapa: "+
                        etapaParticipante.getEtapaParticipante());
            }
            Timestamp timestamp = new Timestamp(System.currentTimeMillis());

            final Participante participanteByIdParticipante1 = participanteByIdParticipante;
            getHibernateTemplate().execute(new HibernateCallback() {
                public Object doInHibernate(org.hibernate.Session session) throws HibernateException, SQLException {
                    Query query = session.createQuery(
                            "delete from PnAgenda where participanteByIdParticipante.idParticipante = ?"
                    );
                    query.setInteger(0, participanteByIdParticipante1.getIdParticipante()); // EMPLEADO - DEPENDE DE PARTICIPANTE
                    query.executeUpdate();
                    return null;
                }
            });

            PnAgenda pnAgenda = new PnAgenda();
            pnAgenda.setParticipanteByIdParticipante(participanteByIdParticipante1);
            pnAgenda.setEmpleadoByIdEmpleadoCreador(empleado);
            pnAgenda.setFechaAgenda(new Timestamp(df.parse(fechaS).getTime()));
            pnAgenda.setFechaCreacion(timestamp);
            getHibernateTemplate().save(pnAgenda);
            return 1;
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

    public List<PnCategoriaCriterio> getCategoriasCriterio(){
        return getHibernateTemplate().find(
                "from PnCategoriaCriterio order by id "
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

    public List<PnCriterio> getPnCriterios(){
        return getHibernateTemplate().find("from PnCriterio order by id");
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
                "from PnCuantitativa where tipoFormatoByIdTipoFormato.id = 3 and empleadoByIdEmpleado.idEmpleado = ?",
                idEmpleado
        );
    }

	public List<MyKey> getTotalesItems(int idEmpleado, int idTipoFormato){
		String hql;
		hql = "select pnSubCapituloByIdSubCapitulo.pnCapituloByIdCapitulo.id, pnSubCapituloByIdSubCapitulo.pnCapituloByIdCapitulo.nombreCapitulo, sum(total) from PnCuantitativa where tipoFormatoByIdTipoFormato.id = ? and empleadoByIdEmpleado.idEmpleado = ? group by pnSubCapituloByIdSubCapitulo.pnCapituloByIdCapitulo";
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

    public List<PnCapitulo> getPnCapitulos(){
        return getHibernateTemplate().find("from PnCapitulo order by id ");
    }

    public List<PnSubCapitulo> getPnSubCapitulos(){
        return getHibernateTemplate().find("from PnSubCapitulo order by codigoItem ");
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

            getHibernateTemplate().execute(new HibernateCallback() {
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
			}
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
		logger.info("entro = ");
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

    public int saveValoracionIndividualCapitulos(boolean definitivo,
												 List<MyKey> visiones,
												 List<MyKey> fortalezas,
                                                 List<MyKey> opertunidades,
                                                 List<MyKey> pendientes,
                                                 List<MyKey> valores
                                                 ){
		logger.info("definitivo = " + definitivo);
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

                    Query query1 = session.createQuery(
                            "delete from PnCualitativa where empleadoByIdEmpleado.idEmpleado = ? and tipoFormatoByIdTipoFormato.id = ?");
                    query1.setInteger(0, empleado.getIdEmpleado());
                    query1.setInteger(1, 2);
                    query1.executeUpdate();
                    return null;
                }
            });

			resetTableIncrement("pn_valoracion");
			resetTableIncrement("pn_cualitativa");

			TipoFormato tipoFormato = getTipoFormato(2);
			for (MyKey key : valores) {
    //            logger.info("ints = " + ints[0] + "\t" + ints[1]);
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


            for (int i = 0; i < fortalezas.size(); i++) {
                MyKey keyVision      	= visiones.get(i);
                MyKey keyFortaleza      = fortalezas.get(i);
                MyKey keyOportunidad    = opertunidades.get(i);
                MyKey keyPendiente      = pendientes.get(i);

    //            logger.info("e.getKey() = " + keyFortaleza.getId() + "\te.getValue() = " + keyFortaleza.getValue() + "\tname " + keyFortaleza.getText());

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

//				logger.info("vision cap = " + keyVision.getText());
				cualitativa.setVision(keyVision.getText());
//                logger.debug("fortalezas = " + keyFortaleza.getText());
                cualitativa.setFortalezas(keyFortaleza.getText());
//                logger.debug("oportunidades = " + keyOportunidad.getText());
                cualitativa.setOportunidades(keyOportunidad.getText());
//                logger.debug("pendientesVisita = " + keyPendiente.getText());
                cualitativa.setPendientesVisita(keyPendiente.getText());

                Integer idCualitativa = (Integer) getHibernateTemplate().save(cualitativa);

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
											   List<MyKey> visiones,
											   List<MyKey> fortalezas,
											   List<MyKey> opertunidades,
											   List<MyKey> pendientes,
											   List<MyKey> valores
	){
//		logger.info("definitivo = " + definitivo);
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

                    Query query1 = session.createQuery(
                            "delete from PnCualitativa where empleadoByIdEmpleado.idEmpleado = ? and tipoFormatoByIdTipoFormato.id = ?");
                    query1.setInteger(0, empleado.getIdEmpleado());
                    query1.setInteger(1, 7); // CONSENSO CAPS
                    query1.executeUpdate();
                    return null;
                }
            });

			resetTableIncrement("pn_valoracion");
			resetTableIncrement("pn_cualitativa");

			TipoFormato tipoFormato = getTipoFormato(7); // CONSENSO CAPS
			for (MyKey key : valores) {
    //            logger.info("ints = " + ints[0] + "\t" + ints[1]);
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


            for (int i = 0; i < fortalezas.size(); i++) {
                MyKey keyVision      	= visiones.get(i);
                MyKey keyFortaleza      = fortalezas.get(i);
                MyKey keyOportunidad    = opertunidades.get(i);
                MyKey keyPendiente      = pendientes.get(i);

    //            logger.info("e.getKey() = " + keyFortaleza.getId() + "\te.getValue() = " + keyFortaleza.getValue() + "\tname " + keyFortaleza.getText());

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

				logger.info("vision cap = " + keyVision.getText());
				cualitativa.setVision(keyVision.getText());
                logger.debug("fortalezas = " + keyFortaleza.getText());
                cualitativa.setFortalezas(keyFortaleza.getText());
                logger.debug("oportunidades = " + keyOportunidad.getText());
                cualitativa.setOportunidades(keyOportunidad.getText());
                logger.debug("pendientesVisita = " + keyPendiente.getText());
                cualitativa.setPendientesVisita(keyPendiente.getText());

                Integer idCualitativa = (Integer) getHibernateTemplate().save(cualitativa);

            }

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
		logger.info("definitivo = " + definitivo);
		try {
			//Borro los datos Anteriores
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
			logger.info("vision = " + vision);
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
//		logger.info("definitivo = " + definitivo);
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
			logger.info("vision = " + vision);
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

	public List<Perfil> getPerfiles(){
		return getHibernateTemplate().find("from Perfil order by perfil ");
	}

	public Empleado vinculaEmpleado(int idPersona,
									int idParticipante,
									int idCargo,
									int idPerfil){
		logger.info("idParticipante = " + idParticipante);
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
			logger.info(e.getMessage());
			return null;
		} catch (DataAccessException e) {
			logger.info(e.getMessage());
			return null;
		} catch (Exception e){
			logger.info(e.getMessage());
			return null;
		}
	}

	public void notificaEmpleadoVinculo(Empleado empleado){
		Persona personaByIdPersona = empleado.getPersonaByIdPersona();
		logger.info("personaByIdPersona = " + personaByIdPersona);
		String asunto = "Vinculado a PNEIG - " + empleado.getParticipanteByIdParticipante().getPnPremioByIdConvocatoria().getNombrePremio()+
                ", " + empleado.getParticipanteByIdParticipante().getEmpresaByIdEmpresa().getNombreEmpresa();
		logger.info("asunto = " + asunto);
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
		logger.info("mensaje = " + mensaje);
		if (personaByIdPersona.getPassword() == null || personaByIdPersona.getPassword().equals("")) { //  SI NO TIENE PASSWORD
			logger.info("no tiene password");
			String password = getRandomPassword();
			logger.info("password = " + password);
			personaByIdPersona.setPassword(getMD5(password));
			getHibernateTemplate().update(personaByIdPersona);
			mensaje += "Password: " + password;
		}
		logger.info("mensaje = " + mensaje);
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

	public List<Participante> getParticipantes(){
		return getHibernateTemplate().find("from Participante where empresaByIdEmpresa.tipoEmpresaByIdTipoEmpresa.id = 2 order by pnPremioByIdConvocatoria.nombrePremio, empresaByIdEmpresa.nombreEmpresa ");
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

    public Empleado selEmpleo(int id){
        try {
            Empleado empleado = getEmpleado(id);
            WebContext wctx = WebContextFactory.get();
            HttpSession session = wctx.getSession(true);
            Empleado empleadoOld = (Empleado) session.getAttribute("empleo");
            if(empleadoOld != null){
                logger.info("empleadoOld.getPerfilByIdPerfil() = " + empleadoOld.getPerfilByIdPerfil());
            } else {
                logger.info("No habia empleo en session");
            }
            session.setAttribute("empleo", empleado);
            return empleado;
        } catch (Exception e) {
            logger.debug(e.getMessage());
            return null;
        }
    }

    public void notificaEvaluadorAspiranteRegitro(Persona aspirante){
        String asunto = "Registro de Aspirante";
        String mensaje =
                "Cordial saludo" +
                        "<br>" +
                        "<br>" +
                        "Le informamos que hemos recibido su solicitud como Aspirante a Evaluador del PNEIG." +
                        "<br>" +
                        "Estamos evaluando su solicitud, en breve le comunicaremos que pasos seguir." +
                        "<br>" +
                        "";
        String[] emails = {aspirante.getEmailPersonal()};
        enviaEmail(emails, asunto, mensaje, null, SUSCRIBE);
    }

    public int registroAspirante(Persona aspirante){
        logger.info("aspirante.getNombre = " + aspirante.getNombrePersona());
        logger.info("aspirante.getApellido() = " + aspirante.getApellido());
        try {
            Persona aspiranteOld = getPersonaFromDoc(aspirante.getDocumentoIdentidad());
            if(aspiranteOld != null){
                aspirante = aspiranteOld;
            } else { // NO EXISTE
                aspirante.setEstado(false);
                aspirante.setLocCiudadByIdCiudad(getCiudad(0));
                aspirante.setFechaCreacion(new Timestamp(System.currentTimeMillis()));
                int idAspirante = (Integer) getHibernateTemplate().save(aspirante);
                aspirante.setIdPersona(idAspirante);
            }
            notificaEvaluadorAspiranteRegitro(aspirante);
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

		WebContext wctx = WebContextFactory.get();
//        HttpSession session = wctx.getSession(true);
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

			logger.info("personaDirectivo.getIdPersona() = " 			+ personaDirectivo.getIdPersona());
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
				logger.info("est 1");

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
			participante.setPnPremioByIdConvocatoria(getPnPremioActivo());
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
			logger.info("e.getMessage() = " + e.getMessage());
			e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
			return 0;
		}
	} /*  FIN INSCRIPCION  */

    public int subeArchivoPostula(byte[] fileInformePostulacionFile){
//        logger.info("fileInformePostulacionFile = " + fileInformePostulacionFile);

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

	public List<PnPremio> getPnPremios(){
		return getHibernateTemplate().find("from PnPremio where idPnPremio > 1");
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
		premio.setTmpFechaDesde(df.format(premio.getFechaDesde()));
		premio.setTmpFechaHasta(df.format(premio.getFechaHasta()));
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

	public int hayPnPremiosActivos(){
		List<PnPremio> premios = getHibernateTemplate().find(
				"from PnPremio where estadoInscripcion = true"
		);
		if (premios.size()>0){
			return premios.get(0).getIdPnPremio();
		} else {
			return 0;
		}
	}

	/**
	 * Retorna el Premio PN activo. Solo puede haber uno
	 * @return p
	 */
	public PnPremio getPnPremioActivo(){
		List<PnPremio> premios = getHibernateTemplate().find(
				"from PnPremio where estadoInscripcion = true"
		);
		if (premios.size()>0){
			return premios.get(0);
		} else {
			return null;
		}
	}

	public int activeDesactivePremioN(int idPremio){
		try {
			int hay = hayPnPremiosActivos();
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

	public int savePnPremio(PnPremio premio ){
		logger.debug("Entro");
		logger.debug("premio.getIdPnPremio() = " + premio.getIdPnPremio());
		try {
			premio.setFechaDesde(new Timestamp(df.parse(premio.getTmpFechaDesde()).getTime()));
			premio.setFechaHasta(new Timestamp(df.parse(premio.getTmpFechaHasta()).getTime()));
			premio.setFechaCreacion(new Timestamp(System.currentTimeMillis()));
			getHibernateTemplate().saveOrUpdate(premio);
			return 1;
		} catch (DataAccessException e) {
			logger.debug(e.getMessage());
			return 0;
		} catch (ParseException e) {
			logger.debug(e.getMessage());
			return 0;
		}
	}

	public List<Empleado> getEmpleosFromPersona(int idPersona){
		List<Empleado> empleados = getHibernateTemplate().find(
				"from Empleado where personaByIdPersona.idPersona = ? order by participanteByIdParticipante.pnPremioByIdConvocatoria.fechaDesde desc ", 
                idPersona
		);
		logger.info("empleados nro = " + empleados.size());
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
			logger.info("Digest(in hex format):: " + hexString.toString());
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
			{"premiogestion@gmail.com", "corca*123", "Mensajes PNEIG"},
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
		logger.info("desdeNombre = " + desdeNombre);
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
//                logger.info("r int = " + r);
			}
			s += SECURE_CHARS[r];
//            logger.info("s.le = " + s.length());
//            logger.info("i = " + i+"\tr = " + r + "\t s:"+s);
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

		wctx.getHttpServletRequest().setAttribute("nombre", texto.getTexto1());
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
}