Este directorio sirve para generar pruebas unitarias.

Las pruebas unitarias deben incluir información inválida,
para verificar cómo debe comportarse el módulo cuando se presente.

# Error

Agregar aquí diversos tipos de archivos corruptos.
Estas pruebas deben fallar (e.g.):

```
error
├── 001_empty.input-format
├── 002_corrupt.input-format
└── 003_truncated.input-format
```

# `data` -> `correct`

Si se agrega información a procesar en `data`
y en `correct` se resuelve correctamente el análisis,
se puede verificar que el resultado del módulo coincide con el esperado.

Los archivos *deben* nombrarse
de acuerdo a la característica o caso que se está probando
y estar numerados de acuerdo al orden en que se quieren probar
(e.g.):

```
data
├── 001_example_case.input-format
└── 002_special_case.input-format
```

# Otras pruebas

Si el módulo requiere otras pruebas unitarias, agregarlas.
