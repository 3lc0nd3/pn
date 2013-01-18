package co.com.elramireza.pn.dao;

import co.com.elramireza.pn.model.*;
import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import javax.servlet.ServletContext;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import static java.lang.String.format;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

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

    SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");

    public String test(String s){
        logger.info("s = " + s);
        return "Hola " + s;
    }

    public List<TipoCargoEmpleado> getTipoCargoEmpleados(){
        return getHibernateTemplate().find("from TipoCargoEmpleado order by tipoCargo ");
    }

    public List<Servicio> getServiciosAjaxPublicos(){
        return getHibernateTemplate().find("from Servicio where tipo = 'a' and publico = 1");
    }

    public List<Servicio> getServiciosPublicosVisibles(){
        return getHibernateTemplate().find("from Servicio where visible = 1 and publico = 1 order by orden ");
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

    public int saveParticipante(Participante participante){
        return (Integer) getHibernateTemplate().save(participante);
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

    public int saveInscrito(Empresa empresa,
                            Persona directivo,
                            Persona empleado){

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

        EmpresaCategoria categoriaEmpresa = getEmpresaCategoria(empresa.getIdEmpresaCategoria());
        logger.debug("categoriaEmpresa.getCategoria() = " + categoriaEmpresa.getCategoria());
        EmpresaCategoriaTamano empresaCategoriaTamano = getEmpresaCategoriaTamano(empresa.getIdEmpresaCategoriaTamano());
        logger.debug("empresaCategoriaTamano.getTamano() = " + empresaCategoriaTamano.getTamano());

        logger.debug("empresa.getFileCertificadoConstitucion() = " + empresa.getFileCertificadoConstitucion());
        logger.debug("empresa.getFileConsignacion() = " + empresa.getFileConsignacion());
        logger.debug("empresa.getFileEstadoFinancieroFile() = " + empresa.getFileEstadoFinancieroFile());
        
        

        logger.debug("directivo.getNombrePersona() = " + directivo.getNombrePersona());
        logger.debug("directivo.getApellido() = " + directivo.getApellido());

        logger.debug("empleado.getNombrePersona() = " + empleado.getNombrePersona());
        logger.debug("empleado.getNombrePersona() = " + empleado.getNombrePersona());
        logger.debug("empleado.getIdCargoEmpleado() = " + empleado.getIdCargoEmpleado());
        logger.debug("empleado.getIdCargoEmpleado() = " + empleado.getIdCargoEmpleado());
        
        CargoEmpleado cargoEmpleado = getCargoEmpleado(empleado.getIdCargoEmpleado());
        logger.debug("cargoEmpleado.getCargo() = " + cargoEmpleado.getCargo());

        Persona directivoOld = getPersonaFromDoc(directivo.getDocumentoIdentidad());
        if(directivoOld != null){  // SI EXISTE
            directivo = directivoOld;
        } else { // NO EXISTE
            directivo.setEstado(true);
            directivo.setLocCiudadByIdCiudad(empresa.getLocCiudadByIdCiudad());
            directivo.setFechaCreacion(new Timestamp(System.currentTimeMillis()));
            int idDirectivo = (Integer) getHibernateTemplate().save(directivo);
            directivo.setIdPersona(idDirectivo);
        }

        Persona empleadoOld = getPersonaFromDoc(empleado.getDocumentoIdentidad());
        if(empleadoOld != null){
            empleado = empleadoOld;
        } else {
            empleado.setEstado(false);
            empleado.setLocCiudadByIdCiudad(empresa.getLocCiudadByIdCiudad());
            empleado.setFechaCreacion(new Timestamp(System.currentTimeMillis()));
            int idEmpleado = (Integer) getHibernateTemplate().save(empleado);
            empleado.setIdPersona(idEmpleado);
        }

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
            System.out.println("path = " + path);

            String fileCertificadoConstitucion  = path+"/cc-"+empresa.getNit()+".pdf";
            String fileEstadoFinanciero         = path+"/ef-"+empresa.getNit()+".pdf";
            String fileConsignacion             = path+"/co-"+empresa.getNit()+".pdf";
            try {
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

            empresa.setFileCertificadoConstitucion(fileCertificadoConstitucion);
            empresa.setFileEstadoFinanciero(fileEstadoFinanciero);
            empresa.setFileConsignacion(fileConsignacion);

            int idEmpresa = (Integer) saveEmpresa(empresa);
            empresa.setIdEmpresa(idEmpresa);
        }
        return 1;
    }

    public List<PnPremio> getPnPremios(){
        return getHibernateTemplate().find("from PnPremio ");
    }

    public PnPremio getPnPremio(int id){
        PnPremio premio = (PnPremio) getHibernateTemplate().get(PnPremio.class, id);
        premio.setTmpFechaDesde(df.format(premio.getFechaDesde()));
        premio.setTmpFechaHasta(df.format(premio.getFechaHasta()));
        return premio;
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
}
