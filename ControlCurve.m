%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% MindStick Control curve 
%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% ZHAOCHAO
%%%%             2016-6-12
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% input:  div_pitch, div_roll, div_yaw
%%%% output: pitch:   value from -1 to 1
%%%%          roll:   value from -1 to 1
%%%%           yaw:   value from -1 to 1
%%%%                  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%
% % % x1 = [ 0 : 0.001 : pi];
% % % k = pi/1.987600108179965;
% % % 
% % % y1 = k * (sin(x1 * 0.95 - pi/2) + 1);
% % % 
% % % x2 = [-pi : 0.001 : 0];
% % % y2 = k * (sin(x2 * 0.95+ pi/2) - 1);
% % % 
% % % x = [-pi : 0.01 : pi];
% % % 
% % % plot(x1, y1, 'r-');
% % % hold on;
% % % plot(x2, y2, 'b-');
% % % plot(x, x);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%

PI_F 	= 3.14159265358979323846

PITCH_THRESHOLD_MIN	    = (-(PI_F/2))	% min pitch threshole -45degree
PITCH_THRESHOLD_MAX	    = (  PI_F/2)

ROLL_THRESHOLD_MIN	    = (-((2*PI_F)/3))
ROLL_THRESHOLD_MAX	    = (  (2*PI_F)/3)

YAW_THRESHOLD_MIN 	    = (-(PI_F/2))
YAW_THRESHOLD_MAX	    = (  PI_F/2)


% % % PITCH_THRESHOLD_OFFSET_MIN	    = (-(PI_F*2))	%
% % % PITCH_THRESHOLD_OFFSET_MAX	    = (  PI_F*2)
% % % 
% % % ROLL_THRESHOLD_OFFSET_MIN	    = (-(PI_F*2))
% % % ROLL_THRESHOLD_OFFSET_MAX	    = (  PI_F*2)
% % % 
% % % YAW_THRESHOLD_OFFSET_MIN 	    = (-(PI_F*2))
% % % YAW_THRESHOLD_OFFSET_MAX	    = (  PI_F*2)

INPUT_MIN             =  -PI_F
INPUT_MAX             =   PI_F

INPUT_PITCH_THRESHOLD_MIN = -0.0504
INPUT_PITCH_THRESHOLD_MAX =  0.0504
INPUT_ROLL_THRESHOLD_MIN = -0.1334
INPUT_ROLL_THRESHOLD_MAX =  0.1334
INPUT_YAW_THRESHOLD_MIN = -0.0998
INPUT_YAW_THRESHOLD_MAX =  0.0998


OUTPUT_PITCH_MIN      =  -1
OUTPUT_PITCH_MAX      =   1

OUTPUT_ROLL_MIN       =  -1
OUTPUT_ROLL_MAX       =   1

OUTPUT_YAW_MIN        =  -1
OUTPUT_YAW_MAX        =   1


OUTPUT_WID            = 2

X_OFFSET              =  0
Y_OFFSET              =  0

X_THRESHOLD_SCALE     =  1.00

K_PITCH               = PI_F / 1.987600108179965
K_ROLL			      = PI_F / 1.987600108179965
K_YAW 			      = PI_F / 1.987600108179965

Y_NEG_MIN                 =   3.159408573835158
% Y_POS_MIN                 =   0
Y_WIDTH                   =   2 * 3.159408573835158

input_pitch = [PITCH_THRESHOLD_MIN : 0.001 : PITCH_THRESHOLD_MAX];
input_roll  = [ROLL_THRESHOLD_MIN  : 0.001 : ROLL_THRESHOLD_MAX];
input_yaw   = [YAW_THRESHOLD_MIN   : 0.001 : YAW_THRESHOLD_MAX];

output_tmp = 0; 
output_pitch = 0;
output_roll  = 0;
output_yaw   = 0;

%%%% PITCH
pitch = ((input_pitch - PITCH_THRESHOLD_MIN)/(PITCH_THRESHOLD_MAX-PITCH_THRESHOLD_MIN)) * (INPUT_MAX - INPUT_MIN) + INPUT_MIN;

index_pos = find(pitch > INPUT_PITCH_THRESHOLD_MAX);
output_tmpn = K_PITCH * (sin(pitch(index_pos) * X_THRESHOLD_SCALE - PI_F/2 + X_OFFSET) - 1 + Y_OFFSET);
index_neg = find(pitch < INPUT_PITCH_THRESHOLD_MIN);
output_tmpp = K_PITCH * (sin(pitch(index_neg) * X_THRESHOLD_SCALE + PI_F/2 + X_OFFSET) + 1 + Y_OFFSET);
index_zero = find(pitch > INPUT_PITCH_THRESHOLD_MIN);
index_zero = find(pitch(index_zero) < INPUT_PITCH_THRESHOLD_MAX);
output_zero = 0 * pitch(index_zero);

output_tmp = [output_tmpn, output_zero, output_tmpp];

% % % if pitch > INPUT_PITCH_THRESHOLD_MAX  
% % %     output_tmp = K_PITCH * (sin(pitch * X_THRESHOLD_SCALE - PI_F/2 + X_OFFSET) + 1 + Y_OFFSET);
% % % elseif pitch < INPUT_PITCH_THRESHOLD_MIN
% % %     output_tmp = K_PITCH * (sin(pitch * X_THRESHOLD_SCALE + PI_F/2 + X_OFFSET) - 1 + Y_OFFSET);
% % % else
% % %     output_tmp = 0  + Y_OFFSET;    
% % % end

% plot(pitch, output_tmp)
output_pitch = ((output_tmp - Y_NEG_MIN) / Y_WIDTH) * (OUTPUT_PITCH_MAX - OUTPUT_PITCH_MIN) - OUTPUT_PITCH_MIN;

%%%% ROLL
roll = ((input_roll - ROLL_THRESHOLD_MIN)/(ROLL_THRESHOLD_MAX-ROLL_THRESHOLD_MIN)) * (INPUT_MAX - INPUT_MIN) + INPUT_MIN;

index_pos = find(roll > INPUT_ROLL_THRESHOLD_MAX);
output_tmpn = K_ROLL * (sin(roll(index_pos) * X_THRESHOLD_SCALE - PI_F/2 + X_OFFSET) - 1 + Y_OFFSET);
index_neg = find(roll < INPUT_ROLL_THRESHOLD_MIN);
output_tmpp = K_ROLL * (sin(roll(index_neg) * X_THRESHOLD_SCALE + PI_F/2 + X_OFFSET) + 1 + Y_OFFSET);
index_zero = find(roll > INPUT_ROLL_THRESHOLD_MIN);
index_zero = find(roll(index_zero) < INPUT_ROLL_THRESHOLD_MAX);
output_zero = 0 * roll(index_zero);

output_tmp = [output_tmpn, output_zero, output_tmpp];
% % % if roll > INPUT_ROLL_THRESHOLD_MAX  
% % %     output_tmp = K_ROLL * sin(roll * X_THRESHOLD_SCALE - PI_F/2 + X_OFFSET) + 1 + Y_OFFSET;
% % % elseif roll < INPUT_ROLL_THRESHOLD_MIN
% % %     output_tmp = K_ROLL * sin(roll * X_THRESHOLD_SCALE + PI_F/2 + X_OFFSET) - 1 + Y_OFFSET;
% % % else
% % %     output_tmp = 0 + Y_OFFSET;    
% % % end
output_roll = ((output_tmp - Y_NEG_MIN) / Y_WIDTH) * (OUTPUT_ROLL_MAX - OUTPUT_ROLL_MIN) - OUTPUT_ROLL_MIN;

%%%% YAW
yaw = ((input_yaw - YAW_THRESHOLD_MIN)/(YAW_THRESHOLD_MAX-YAW_THRESHOLD_MIN)) * (INPUT_MAX - INPUT_MIN) + INPUT_MIN;

index_pos = find(yaw > INPUT_YAW_THRESHOLD_MAX);
output_tmpn = K_YAW * (sin(yaw(index_pos) * X_THRESHOLD_SCALE - PI_F/2 + X_OFFSET) - 1 + Y_OFFSET);
index_neg = find(yaw < INPUT_YAW_THRESHOLD_MIN);
output_tmpp = K_YAW * (sin(yaw(index_neg) * X_THRESHOLD_SCALE + PI_F/2 + X_OFFSET) + 1 + Y_OFFSET);
index_zero = find(yaw > INPUT_YAW_THRESHOLD_MIN);
index_zero = find(yaw(index_zero) < INPUT_YAW_THRESHOLD_MAX);
output_zero = 0 * yaw(index_zero);

output_tmp = [output_tmpn, output_zero, output_tmpp];

% % % if yaw > INPUT_YAW_THRESHOLD_MAX  
% % %     output_tmp = K_YAW * sin(yaw * X_THRESHOLD_SCALE - PI_F/2 + X_OFFSET) + 1 + Y_OFFSET;
% % % elseif yaw < INPUT_YAW_THRESHOLD_MIN
% % %     output_tmp = K_YAW * sin(yaw * X_THRESHOLD_SCALE + PI_F/2 + X_OFFSET) - 1 + Y_OFFSET;
% % % else
% % %     output_tmp = 0 + Y_OFFSET;    
% % % end
output_yaw = ((output_tmp - Y_NEG_MIN) / Y_WIDTH) * (OUTPUT_YAW_MAX - OUTPUT_YAW_MIN) - OUTPUT_YAW_MIN;

%%%% plot the curve
figure(1);
plot(input_pitch, output_pitch, 'ro-');
hold on;
plot(input_roll, output_roll, 'b*-');
plot(input_yaw, output_yaw, 'g^-');
title('Control Curve');
legend('Pitch', 'Roll', 'Yaw');
grid on;
axis auto;
