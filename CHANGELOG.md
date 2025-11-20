# Changelog

Todos los cambios notables de este proyecto serán documentados en este archivo.

## [1.2.0] - 2024-11-20

### ✨ Agregado
- **Sistema de Auditoría** completo para tracking de actividades
- **Historial de actividades** con filtros por usuario, acción y fechas
- **Logging automático** de login, logout, CRUD operations
- **Información detallada** de IP, User Agent y timestamps
- **Acceso restringido** solo para administradores

### 🎨 Interfaz
- **Iconos en lugar de botones** para acciones (Ver, Editar, Eliminar)
- **Logos actualizados** en menú y página de bienvenida
- **Iconos específicos** para agregar subclientes y proveedores
- **Alineación mejorada** de iconos en tablas
- **Colores intuitivos** por tipo de acción

### 🔧 Corregido
- **Logout funcionando** correctamente con Turbo
- **Callbacks de auditoría** sin interferir con Devise
- **Tracking selectivo** evitando controladores problemáticos

### 🔒 Seguridad
- **Auditoría completa** de todas las acciones del usuario
- **Registro de sesiones** con información de contexto
- **Historial protegido** solo para administradores

## [1.1.0] - 2024-11-20

### ✨ Agregado
- **Sistema de Operaciones** completo con todos los campos logísticos
- **Formularios de operaciones** para crear, editar y visualizar
- **Relaciones con empresas** por tipo (Shipper, Consignatario, Agente, etc.)
- **Campos financieros** para facturación y compras
- **Numeración automática** correlativa de operaciones
- **Validaciones** de datos y tipos de operación
- **Navegación** integrada en menú principal

### 🔧 Corregido
- **Error de unicidad** en código de empresas vacío
- **Métodos privados** en modelo Company ahora públicos
- **Select de clientes** muestra nombre comercial o razón social
- **Formularios** con valores preseleccionados correctamente

### 📱 Interfaz
- **Vista detallada** de operaciones con información organizada
- **Formularios responsive** con grid layout
- **Listado de operaciones** con datos clave
- **Selects dinámicos** filtrados por tipo de empresa

## [1.0.0] - 2024-11-20

### ✨ Agregado
- **Sistema de autenticación** con Devise
- **Gestión de usuarios** con roles (admin, manager, user)
- **Modelo de empresas** con tipos logísticos específicos
- **Sistema de contactos** vinculados a empresas
- **Ubicaciones geográficas** con países, regiones, provincias y comunas
- **Relaciones empresa-subcliente-proveedor** con modelo many-to-many
- **Interfaz web responsive** con CSS personalizado
- **Selects dependientes** para ubicación geográfica con JavaScript
- **API REST** para datos de ubicación
- **Seeds** con 248 países y división territorial completa de Chile
- **Validaciones** de datos y tipos de empresa
- **Navegación contextual** según rol de usuario
- **Campo nombre** en usuarios para personalización
- **Mensajes de bienvenida** personalizados

### 🛠️ Técnico
- **Ruby 3.3.0** como versión base
- **Rails 8.0.4** con las últimas características
- **PostgreSQL** para base de datos en producción
- **Stimulus** para interactividad JavaScript
- **Turbo** para navegación SPA
- **Importmap** para gestión de JavaScript
- **Propshaft** para pipeline de assets

### 🔐 Seguridad
- **Autenticación robusta** con Devise
- **Autorización por roles** en controladores
- **Validación de parámetros** con strong parameters
- **Protección CSRF** habilitada
- **Headers de seguridad** configurados

### 🌍 Datos
- **248 países** con códigos ISO2, ISO3 y códigos telefónicos
- **16 regiones** de Chile
- **56 provincias** de Chile  
- **346 comunas** de Chile con códigos oficiales
- **Usuarios por defecto** para administración

### 📱 Interfaz
- **Diseño responsive** para móviles y desktop
- **Navegación intuitiva** con menús contextuales
- **Formularios dinámicos** con validación en tiempo real
- **Mensajes de estado** para feedback del usuario
- **Botones de acción** contextuales por registro

### 🔄 API
- **Endpoints RESTful** para datos geográficos
- **Respuestas JSON** optimizadas
- **Filtrado por relaciones** padre-hijo
- **Compatibilidad con Turbo** para requests AJAX

### 🚀 Despliegue
- **Configuración de producción** con PostgreSQL
- **Assets precompilados** para rendimiento
- **Variables de entorno** para configuración
- **Scripts de despliegue** automatizados
- **SSL/HTTPS** configurado con Let's Encrypt
- **NGINX** como proxy reverso

## [Próximas Versiones]

### 🎯 Planificado
- Dashboard con métricas de empresas
- Exportación de datos a Excel/PDF
- Sistema de notificaciones
- Auditoría de cambios
- API completa para integraciones
- Búsqueda avanzada y filtros
- Gestión de documentos
- Reportes personalizables

---

**Formato basado en [Keep a Changelog](https://keepachangelog.com/)**