package co.com.elramireza.pn.dao;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.dao.DataAccessException;
import org.directwebremoting.WebContextFactory;
import org.directwebremoting.WebContext;

import java.util.List;
import java.sql.Timestamp;
import java.io.FileOutputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.text.ParseException;

import co.com.elramireza.pn.model.*;

import javax.servlet.http.HttpSession;
import javax.servlet.ServletContext;

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
        return (Texto) getHibernateTemplate().get(Texto.class, id);
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

    public int savePersona(Persona persona){
        return (Integer) getHibernateTemplate().save(persona);
    }

    public int saveEmpresa(Empresa empresa){
        return (Integer) getHibernateTemplate().save(empresa);
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

    public EmpresaCategoriaTamano getEmpresaCategoriaTamano(int id){
        return (EmpresaCategoriaTamano) getHibernateTemplate().get(EmpresaCategoriaTamano.class, id);
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

    public int saveInscrito(Empresa empresa,
                            Persona directivo,
                            Persona empleado){

        WebContext wctx = WebContextFactory.get();
        HttpSession session = wctx.getSession(true);
        ServletContext context = wctx.getServletContext();

        logger.info("empresa.getNit() = " + empresa.getNit());
        logger.info("empresa.getNombreEmpresa() = " + empresa.getNombreEmpresa());
        logger.info("empresa.getPublicaEmpresa() = " + empresa.getPublicaEmpresa());
        logger.info("empresa.getIdEmpresaCategoriaTamano() = " + empresa.getIdEmpresaCategoriaTamano());
        empresa.setLocCiudadByIdCiudad(getCiudad(empresa.getLocCiudadEmpresa()));
        logger.info("empresa.getLocCiudadByIdCiudad().getNombreCiudad() = " + empresa.getLocCiudadByIdCiudad().getNombreCiudad());
        logger.info("empresa.getMarcas() = " + empresa.getMarcas());

        EmpresaCategoria categoriaEmpresa = getEmpresaCategoria(empresa.getIdEmpresaCategoria());
        logger.info("categoriaEmpresa.getCategoria() = " + categoriaEmpresa.getCategoria());
        EmpresaCategoriaTamano empresaCategoriaTamano = getEmpresaCategoriaTamano(empresa.getIdEmpresaCategoriaTamano());
        logger.info("empresaCategoriaTamano.getTamano() = " + empresaCategoriaTamano.getTamano());

        logger.info("empresa.getFileCertificadoConstitucion() = " + empresa.getFileCertificadoConstitucion());
        logger.info("empresa.getFileConsignacion() = " + empresa.getFileConsignacion());
        logger.info("empresa.getFileEstadoFinancieroFile() = " + empresa.getFileEstadoFinancieroFile());
        
        

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
            directivo.setEstado(0);
            directivo.setLocCiudadByIdCiudad(empresa.getLocCiudadByIdCiudad());
            directivo.setFechaCreacion(new Timestamp(System.currentTimeMillis()));
            int idDirectivo = (Integer) getHibernateTemplate().save(directivo);
            directivo.setId(idDirectivo);
        }

        Persona empleadoOld = getPersonaFromDoc(empleado.getDocumentoIdentidad());
        if(empleadoOld != null){
            empleado = empleadoOld;
        } else {
            empleado.setEstado(0);
            empleado.setLocCiudadByIdCiudad(empresa.getLocCiudadByIdCiudad());
            empleado.setFechaCreacion(new Timestamp(System.currentTimeMillis()));
            int idEmpleado = (Integer) getHibernateTemplate().save(empleado);
            empleado.setId(idEmpleado);
        }

        Empresa empresaOld = getEmpresaFromNit(empresa.getNit());
        if(empresaOld != null){
            empresa = empresaOld;
        } else {
            empresa.setFechaCreacion(new Timestamp(System.currentTimeMillis()));
            empresa.setTipoEmpresaByIdTipoEmpresa(getTipoEmpresa(2));
            empresa.setEstado(0); // sin aprovar
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
            empresa.setId(idEmpresa);
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

    public int savePnPremio(PnPremio premio ){
        logger.info("Entro");
        logger.info("premio.getIdPnPremio() = " + premio.getIdPnPremio());
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
