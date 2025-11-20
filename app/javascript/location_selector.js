function initializeLocationSelector() {
  const countrySelect = document.getElementById('company_country');
  const chileFields = document.getElementById('chile-fields');
  const regionSelect = document.getElementById('company_region');
  const provinceSelect = document.getElementById('company_province');
  const communeSelect = document.getElementById('company_commune');

  if (!countrySelect) return;

  // Datos embebidos
  const chileData = window.chileLocationData;

  function toggleChileFields() {
    if (countrySelect.value === 'Chile') {
      chileFields.style.display = 'block';
    } else {
      chileFields.style.display = 'none';
      clearSelects();
    }
  }

  function clearSelects() {
    regionSelect.value = '';
    provinceSelect.innerHTML = '<option value="">Seleccionar provincia</option>';
    communeSelect.innerHTML = '<option value="">Seleccionar comuna</option>';
  }

  function loadProvinces() {
    const regionName = regionSelect.value;
    provinceSelect.innerHTML = '<option value="">Seleccionar provincia</option>';
    communeSelect.innerHTML = '<option value="">Seleccionar comuna</option>';
    
    if (!regionName || !chileData) return;

    const region = chileData.find(r => r.region === regionName);
    if (region) {
      region.provincias.forEach(province => {
        const option = document.createElement('option');
        option.value = province.name;
        option.textContent = province.name;
        provinceSelect.appendChild(option);
      });
    }
  }

  function loadCommunes() {
    const regionName = regionSelect.value;
    const provinceName = provinceSelect.value;
    communeSelect.innerHTML = '<option value="">Seleccionar comuna</option>';
    
    if (!regionName || !provinceName || !chileData) return;

    const region = chileData.find(r => r.region === regionName);
    if (region) {
      const province = region.provincias.find(p => p.name === provinceName);
      if (province) {
        province.comunas.forEach(commune => {
          const option = document.createElement('option');
          option.value = commune.name;
          option.textContent = commune.name;
          communeSelect.appendChild(option);
        });
      }
    }
  }

  // Remover listeners anteriores si existen
  countrySelect.removeEventListener('change', toggleChileFields);
  regionSelect.removeEventListener('change', loadProvinces);
  provinceSelect.removeEventListener('change', loadCommunes);

  // Agregar nuevos listeners
  countrySelect.addEventListener('change', toggleChileFields);
  regionSelect.addEventListener('change', loadProvinces);
  provinceSelect.addEventListener('change', loadCommunes);

  // Inicializar
  toggleChileFields();
}

// Ejecutar en carga inicial y en navegación Turbo
document.addEventListener('DOMContentLoaded', initializeLocationSelector);
document.addEventListener('turbo:load', initializeLocationSelector);
document.addEventListener('turbo:render', initializeLocationSelector);