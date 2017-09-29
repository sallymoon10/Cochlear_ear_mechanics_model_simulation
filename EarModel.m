classdef EarModel< handle
    methods (Static) 
        
        % Implements state space equation of middle ear for normal and
        % varying severity of otosclerosis
        function dx = getDerivative(pressure,x, earStatus)
            % Stapes material properties for normal ear
            if (isequal(earStatus, 'normal'))
                A = [-4000/0.45 -2100000/0.45 ;
                1 0];
                B = [1/0.45;
                0];
            % Stapes material properties for mild 
            elseif (isequal(earStatus, 'otoMild'))
                A = [-4000/0.45 -3150000/0.45 ;
                1 0];
                B = [1/0.45;
                0];
            elseif (isequal(earStatus, 'otoModerate'))
                A = [-4000/0.45 -21000000/0.45 ;
                1 0];
                B = [1/0.45;
                0];
            elseif (isequal(earStatus,  'otoSevere'))
                A = [-4000/0.45 -210000000/0.45 ;
                1 0];
                B = [1/0.45;
                0];
            end
            dx = A * x + B * pressure;
        end
        
        % Simulates middle ear mechanics for a given pressure using ode45
        function [time, state] = simulateEar(pressure, earStatus)
            initialState = [0, 0];
            odefun = @(t, x) EarModel.getDerivative(pressure, x, earStatus);
            [time, state] = ode45(odefun, [0 0.1], initialState);
        end
        
        % Obtain stapes displacement of specified ear given one pressure value 
        function stapesDisplacement = getStapesDisplacement(pressure, earStatus)
            [time, state] = EarModel.simulateEar(pressure, earStatus);
            stapesDisplacementArray = state(:,2);
            lengthOfArray = length(time);
           
            stabilizedStapesDisplacementArray = stapesDisplacementArray(round(lengthOfArray/2): lengthOfArray);
            stapesDisplacement = mean(stabilizedStapesDisplacementArray);
        end
        
        % Obtain stapes displacement array for a range of frequency values 
        function stapesDisplacementArray = getStapesDisplacementArray(earStatus, frequencyArray)
            pressureArray = EarModel.getPressureArray(frequencyArray);
       
            stapesDisplacementArray = [];
            
            for i = 1: length(pressureArray)
                stapesDisplacementArray(i) = EarModel.getStapesDisplacement(pressureArray(i), earStatus);
            end
         end
        
        % Obtain pressure array that corresponds to frequency array
        function pressureArray = getPressureArray(frequencyArray)
            pressureArray = [];
            for i = 1 : length(frequencyArray)
                if (frequencyArray(i) > 0 && frequencyArray(i) < 1000) 
                    pressureArray(i) = 0.001*(frequencyArray(i))- 0.0747;
                elseif (frequencyArray(i) >= 1000 && frequencyArray(i) <= 20000)
                    pressureArray(i) = -0.00000002*(frequencyArray(i))^2 +0.0003*frequencyArray(i) +0.698;
                end
            end
        end

    end
end