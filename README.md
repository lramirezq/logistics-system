# Sistema de Logística

Sistema web para gestión de empresas logísticas desarrollado en Ruby on Rails 8.

## 🚀 Características

- **Autenticación de usuarios** con roles (Admin, Manager, Usuario)
- **Gestión de empresas** con tipos logísticos específicos
- **Contactos por empresa** con información completa
- **Ubicaciones geográficas** con datos de países y división territorial de Chile
- **Relaciones empresa-subcliente-proveedor** con sistema many-to-many
- **Interfaz responsive** con CSS moderno
- **Selects dependientes** para ubicación geográfica

## 🛠️ Tecnologías

- **Ruby 3.3.0**
- **Rails 8.0.4**
- **PostgreSQL** (producción) / SQLite (desarrollo)
- **Devise** para autenticación
- **Stimulus** para JavaScript
- **Turbo** para navegación SPA
- **CSS** personalizado

## 📋 Requisitos

- Ruby 3.3.0
- Node.js 20+
- PostgreSQL (para producción)
- Bundler

## 🔧 Instalación

```bash
# Clonar repositorio
git clone <repository-url>
cd logistics-system

# Instalar dependencias
bundle install
npm install

# Configurar base de datos
rails db:create db:migrate db:seed

# Iniciar servidor
rails server
```

## 👥 Usuarios por Defecto

Después de ejecutar `rails db:seed`:

- **Administrador:** admin@logistics.com / password123
- **Manager:** manager@logistics.com / password123

## 🏢 Tipos de Empresas

- **SHIPPER** - Exportador/Embarcador
- **CONSIGNATARIO** - Importador/Consignatario
- **AGENTE** - Agente de carga
- **COMPANIA** - Compañía naviera
- **NAVIERA** - Línea naviera
- **MULTIPLE** - Múltiples servicios

## 🌍 Datos Geográficos

El sistema incluye:
- **248 países** con códigos ISO
- **16 regiones** de Chile
- **56 provincias** de Chile
- **346 comunas** de Chile

## 🔐 Roles y Permisos

### Administrador
- Gestión completa de usuarios
- Gestión completa de empresas
- Acceso a todas las funcionalidades

### Manager
- Gestión de empresas
- Gestión de contactos
- Sin acceso a gestión de usuarios

### Usuario
- Solo lectura de empresas
- Gestión limitada de contactos

## 🗂️ Estructura del Proyecto

```
app/
├── controllers/
│   ├── application_controller.rb
│   ├── companies_controller.rb
│   ├── contacts_controller.rb
│   ├── home_controller.rb
│   ├── users_controller.rb
│   └── api/location_controller.rb
├── models/
│   ├── user.rb
│   ├── company.rb
│   ├── contact.rb
│   ├── country.rb
│   ├── region.rb
│   ├── province.rb
│   ├── commune.rb
│   └── company_relationship.rb
├── views/
│   ├── layouts/
│   ├── home/
│   ├── companies/
│   ├── contacts/
│   ├── users/
│   └── devise/
└── javascript/
    ├── application.js
    └── location_selector.js
```

## 🔄 API Endpoints

- `GET /api/regions/:country_id` - Regiones por país
- `GET /api/provinces/:region_id` - Provincias por región  
- `GET /api/communes/:province_id` - Comunas por provincia

## 🚀 Despliegue

Ver archivo `DEPLOYMENT.md` para instrucciones detalladas de despliegue en producción.

## 📝 Desarrollo

```bash
# Ejecutar tests
rails test

# Consola Rails
rails console

# Generar migración
rails generate migration NombreMigracion

# Ejecutar migraciones
rails db:migrate
```

## 🤝 Contribución

1. Fork el proyecto
2. Crear rama feature (`git checkout -b feature/nueva-funcionalidad`)
3. Commit cambios (`git commit -am 'Agregar nueva funcionalidad'`)
4. Push a la rama (`git push origin feature/nueva-funcionalidad`)
5. Crear Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT.