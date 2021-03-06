# MLsimulator
This is a MatLab/Multi-Layer simulation tools for wireless network.

With the development of wireless network, more and more strict requirements are raised, such as highly dense deployment and fair QoS guarantee. These requirements not only need advanced PHY techniques and MAC protocols separately, but also require different layers to work together, such as IEEE 802.11ax protocol. Because it can help layers to decide better strategies and promote efficiency by exchanging some information through interface between layers. Researchers often use simulation to evaluate the performance of new PHY techniques or MAC protocols before making prototypes. However, simulation tools for MAC protocols are almost based on C/C++, while simulation tools for PHY techniques are almost based on MATLAB. Because verification of MAC protocols are on the system level and require node models to construct topology, which is easier to be implemented by object-oriented programming language. Conversely, MATLAB has obvious advantages in mathematical calculating and debugging, and hence it is almost used for verification of PHY techniques on link level, such as encoding/decoding, detecting signals and eliminating noise.

Nowadays, performance of computers does not limit the design of simulation so much as past. Therefore, we can do simulation with more details to make it closer to real world. Up to our best knowledge, there is no general simulation tools for crosslayer simulation due to the gap between programming language. In fact, MATLAB can support object-oriented programming, although there are some limitations compared to C/C++. Therefore, we design and implement a multi-layer simulation tool based on MATLAB.

Altering or running this program for non-business use is allowed.

If you have any question or find a bug, please contact linwest@vip.qq.com
