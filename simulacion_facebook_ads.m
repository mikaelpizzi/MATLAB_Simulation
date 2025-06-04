% -------------------------------------------------------------------------
% PROYECTO: Simulación de Impacto de Campaña Facebook Ads en Ventas
% Basado en el Reporte del Proyecto para una tienda de ropa en Mérida
% -------------------------------------------------------------------------
clc;            % Limpia la ventana de comandos
clear;          % Limpia las variables del espacio de trabajo
close all;      % Cierra todas las figuras abiertas

% --- 1. VARIABLES DE ENTRADA (Suposiciones y Datos de la Tienda/Campaña) ---
% Valores iniciales

% Datos base de la tienda
ventas_base_mensuales = 2000; % USD - Ingresos mensuales estimados de la tienda
% Calculamos las ventas diarias promedio para el modelo, asumiendo 30 días por mes
ventas_base_diarias = ventas_base_mensuales / 30;

% Parámetros de la campaña de Facebook Ads 
presupuesto_total_campana = 100; % USD - Presupuesto asignado (inicial)
cpc_estimado = 0.50;            % USD - Costo Por Clic (CPC)
tasa_conversion_web_estimada = 0.05; % 5% - Tasa de conversión 
valor_pedido_promedio = 50;     % USD - Valor promedio de venta

% Duración de la campaña: 30 días o hasta que se agote el presupuesto
% para el presupuesto de $100, pero es necesario para cálculos diarios y evolución.
duracion_campana_dias = 30;     

% --- 2. CÁLCULOS DEL MODELO ---

% A. Cálculos basados en el "Análisis preliminar" del reporte (Totales de campaña)
clics_totales_estimados_campana = presupuesto_total_campana / cpc_estimado;
ventas_generadas_campana_unidades = clics_totales_estimados_campana * tasa_conversion_web_estimada;
ingresos_proyectados_campana_total = ventas_generadas_campana_unidades * valor_pedido_promedio;

% ROI (Return On Investment): (Ingresos - Costo) / Costo
if presupuesto_total_campana > 0
    roi_reporte = (ingresos_proyectados_campana_total - presupuesto_total_campana) / presupuesto_total_campana;
else
    roi_reporte = 0;
end

% ROAS (Return On Ad Spend): Ingresos / Costo (métrica común en publicidad)
if presupuesto_total_campana > 0
    roas_campana = ingresos_proyectados_campana_total / presupuesto_total_campana;
else
    roas_campana = 0;
end

% Incremento porcentual en ventas MENSUALES 
% Se compara el ingreso ADICIONAL TOTAL de la campaña con las ventas base MENSUALES.
incremento_ventas_mensuales_porc = (ingresos_proyectados_campana_total / ventas_base_mensuales) * 100;


% B. Cálculos diarios (si la duración de la campaña es relevante)
presupuesto_diario_campana = presupuesto_total_campana / duracion_campana_dias;
clics_diarios_esperados_campana = presupuesto_diario_campana / cpc_estimado;
conversiones_diarias_adicionales_campana = clics_diarios_esperados_campana * tasa_conversion_web_estimada;
ingresos_diarios_adicionales_campana = conversiones_diarias_adicionales_campana * valor_pedido_promedio;
ventas_totales_diarias_con_campana = ventas_base_diarias + ingresos_diarios_adicionales_campana;


% --- 3. MOSTRAR RESULTADOS EN LA VENTANA DE COMANDOS ---
disp('-------------------------------------------------------------------');
disp('    SIMULACIÓN DE CAMPAÑA FACEBOOK ADS - TIENDA DE ROPA   ');
disp('-------------------------------------------------------------------');
fprintf('DATOS BASE DE LA TIENDA (Según Reporte):\n');
fprintf('  Ingresos mensuales estimados (sin ads): $%.2f\n', ventas_base_mensuales);
fprintf('  Ventas base diarias (estimadas):        $%.2f\n\n', ventas_base_diarias);

fprintf('PARÁMETROS DE LA CAMPAÑA (Según "Análisis preliminar" o ajustados):\n');
fprintf('  Presupuesto total de la campaña:        $%.2f\n', presupuesto_total_campana);
fprintf('  Duración de la campaña (para desglose): %d días\n', duracion_campana_dias);
fprintf('  Costo Por Clic (CPC) estimado:          $%.2f\n', cpc_estimado);
fprintf('  Tasa de conversión web estimada:        %.1f%%\n', tasa_conversion_web_estimada * 100);
fprintf('  Valor de pedido promedio:               $%.2f\n\n', valor_pedido_promedio);

disp('RESULTADOS TOTALES ESTIMADOS DE LA CAMPAÑA (Coherencia con Reporte):');
fprintf('  Número de clics estimados TOTALES:      %.0f clics (Reporte: 200)\n', clics_totales_estimados_campana);
fprintf('  Ventas generadas TOTALES (unidades):    %.0f unidades (Reporte: 10)\n', ventas_generadas_campana_unidades);
fprintf('  Ingresos proyectados TOTALES (de ads):  $%.2f (Reporte: $500)\n', ingresos_proyectados_campana_total);
fprintf('  ROI (según cálculo del reporte):        %.0f%% (Reporte: 400%%)\n', roi_reporte * 100);
fprintf('  ROAS (Ingresos/Costo):                  %.2fx\n\n', roas_campana);

disp('IMPACTO EN VENTAS GENERALES:');
fprintf('  Incremento estimado en ventas MENSUALES: %.2f%% (Reporte: ~16.67%%*)\n', incremento_ventas_mensuales_porc);
disp('     *Nota: El reporte menciona 16.67%. Con $500 ingresos/$2000 base, el cálculo es 25%.');
disp('      La diferencia puede deberse a redondeos o una base de cálculo distinta en el reporte para ese % específico.');
fprintf('  Ventas totales diarias PROMEDIO (con ads): $%.2f (si la campaña dura %d días)\n\n', ventas_totales_diarias_con_campana, duracion_campana_dias);

disp('DESGLOSE DIARIO ESTIMADO (si la campaña dura más de 1 día):');
fprintf('  Presupuesto diario de la campaña:       $%.2f\n', presupuesto_diario_campana);
fprintf('  Clics diarios esperados (de ads):       %.1f clics\n', clics_diarios_esperados_campana);
fprintf('  Compras diarias adicionales (de ads):    %.1f compras\n', conversiones_diarias_adicionales_campana);
fprintf('  Ingresos diarios adicionales (de ads):  $%.2f\n\n', ingresos_diarios_adicionales_campana);


% --- 4. VISUALIZACIÓN GRÁFICA ---

% Gráfico 1: Comparación de ventas diarias (si se define duración > 0)
if duracion_campana_dias > 0
    figure;
    categorias_ventas = {'Ventas Base Diarias', sprintf('Ventas Diarias con Campaña (durante %d días)', duracion_campana_dias)};
    valores_ventas = [ventas_base_diarias, ventas_totales_diarias_con_campana];
    bar_plot = bar(valores_ventas);
    set(gca, 'XTickLabel', categorias_ventas);
    ylabel('Ingresos Diarios (USD)');
    title('Comparación de Ingresos Diarios Estimados');
    grid on;
    % Añadir etiquetas de valor a las barras
    xtips = bar_plot.XEndPoints;
    ytips = bar_plot.YEndPoints;
    labels = string(arrayfun(@(x) sprintf('$%.2f', x), valores_ventas, 'UniformOutput', false));
    text(xtips, ytips, labels, 'HorizontalAlignment','center', 'VerticalAlignment','bottom', 'FontSize',10, 'FontWeight', 'bold');
end

% Gráfico 2: Desglose de ingresos diarios durante la campaña (si duración > 0)
if duracion_campana_dias > 0
    figure;
    % Asegurarse que los ingresos adicionales no sean negativos para el pie chart
    ingresos_adicionales_positivos = max(0, ingresos_diarios_adicionales_campana);
    ingresos_componentes = [ventas_base_diarias, ingresos_adicionales_positivos];
    % Solo mostrar la etiqueta de ads si hay ingresos adicionales
    if ingresos_adicionales_positivos > 0
        labels_componentes = {sprintf('Ingresos Base ($%.2f)', ventas_base_diarias), ...
                              sprintf('Ingresos por Ads ($%.2f)', ingresos_adicionales_positivos)};
    else
        labels_componentes = {sprintf('Ingresos Base ($%.2f)', ventas_base_diarias), ''};
    end
    if sum(ingresos_componentes) > 0 % Evitar error si todo es cero
      pie(ingresos_componentes, labels_componentes);
      title(sprintf('Desglose de Ingresos Diarios Estimados (durante %d días de campaña)', duracion_campana_dias));
    else
      disp('No se puede generar gráfico de pastel, todos los valores son cero o negativos.');
    end
end

% Gráfico 3: Evolución de ingresos y ROAS (si duración > 1 día)
if duracion_campana_dias > 1
    dias_vector = 1:duracion_campana_dias;
    ingresos_acumulados_campana_vector = cumsum(ones(1, duracion_campana_dias) * ingresos_diarios_adicionales_campana);
    costo_acumulado_campana_vector = cumsum(ones(1, duracion_campana_dias) * presupuesto_diario_campana);
    
    % Evitar división por cero si el costo es cero en algún punto (aunque no debería con presupuesto > 0)
    roas_evolucion_vector = zeros(size(costo_acumulado_campana_vector));
    indices_costo_positivo = costo_acumulado_campana_vector > 0;
    roas_evolucion_vector(indices_costo_positivo) = ingresos_acumulados_campana_vector(indices_costo_positivo) ./ costo_acumulado_campana_vector(indices_costo_positivo);

    figure;
    subplot(2,1,1); % Dos gráficos en una figura: 2 filas, 1 columna, este es el 1ro
    plot(dias_vector, ingresos_acumulados_campana_vector, 'b-o', 'LineWidth', 1.5, 'DisplayName', 'Ingresos Acumulados por Ads');
    hold on;
    plot(dias_vector, costo_acumulado_campana_vector, 'r--s', 'LineWidth', 1.5, 'DisplayName', 'Costo Acumulado de Campaña');
    hold off;
    title('Evolución Acumulada: Ingresos de Ads vs. Costo de Campaña');
    xlabel(sprintf('Día de la Campaña (Total %d días)', duracion_campana_dias));
    ylabel('Monto Acumulado (USD)');
    legend('Location', 'northwest');
    grid on;

    subplot(2,1,2); % Este es el 2do gráfico
    plot(dias_vector, roas_evolucion_vector, 'g-d', 'LineWidth', 1.5, 'DisplayName', 'ROAS');
    hold on;
    line([dias_vector(1) dias_vector(end)], [1 1], 'Color', 'black', 'LineStyle', ':', 'DisplayName', 'Punto de Equilibrio (ROAS=1)'); % Línea de ROAS = 1
    hold off;
    title('Evolución del ROAS Durante la Campaña');
    xlabel(sprintf('Día de la Campaña (Total %d días)', duracion_campana_dias));
    ylabel('ROAS (x)');
    legend('Location', 'northwest');
    grid on;
end

disp('-------------------------------------------------------------------');
disp('Simulación completada. Revisa los resultados y gráficos generados.');
disp('AJUSTA LAS VARIABLES DE ENTRADA para simular diferentes escenarios.');
disp('-------------------------------------------------------------------');