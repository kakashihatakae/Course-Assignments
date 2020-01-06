import numpy as np
import random 
import sys

#Author : Shreyas Bhujbal

class Neural_Net:
  #num_layers is a list
    def __init__(self, num_layers, alpha, iters, data_file):
        self.data_file = data_file
        print('----------------------')
        print('alpha: ' ,alpha)
        print('')
        self.w = []
        self.b = []
        #################################
        self.output_neurons = 4
        ################################
        num_layers.append(self.output_neurons)
        prev_num_layer = 192
        for i in num_layers:
            self.w.append(np.zeros((i, prev_num_layer)))
            prev_num_layer = i
    
        for i in num_layers:
            self.b.append(np.zeros((i,1)))
        
        self.image_strs = ''
        self.num_layers = num_layers
        self.alpha = alpha
        self.iters = iters


    #update
    def activation(self, x):
        # print('x: ', x)
        y = 1/(1+((np.e)**(-x)))
        # y = np.tanh(x)
        # y = x*(x>0)
        return y
        
    def parse_images(self):
        file_train = open(self.data_file, 'r')
        image_strs = file_train.readlines(0)
        self.image_strs = image_strs
        

    def scale(self, x):
        factor = 0.99/255
        return x*factor + 0.01

    def feed_forward(self, inputs):
        z = []
        activations = []
        activations.append(inputs)
        for layer in range(len(self.num_layers)):
            # print(inputs.shape)  
            w_x_b = np.dot(self.w[layer], inputs) + self.b[layer]
            neuron_activation = self.activation(w_x_b)
            activations.append(neuron_activation)
            z.append(w_x_b)

            inputs =  neuron_activation

        return [z, activations]

    #update
    def activation_prime(self, x):
        # print(self.activation(x))
        return (self.activation(x))*(1-self.activation(x))
        # return (1 - (self.activation(x))**2)
        # return 1*(x>0)

    #update
    def loss(self, x,y):
        pass

    #update
    def loss_prime(self, x, y):
        # print(x-y)
        # print('')
        return (x-y)

    def logits(self, Y):
        if Y == 0:
            return np.array([0.99,0.01,0.01,0.01]).reshape(4,1)
        if Y == 90:
            return np.array([0.01,0.99,0.01,0.01]).reshape(4,1)
        if Y == 180:
            return np.array([0.01,0.01,0.99,0.01]).reshape(4,1)
        if Y == 270:
            return np.array([0.01,0.01,0.01,0.99]).reshape(4,1)
    

    # http://neuralnetworksanddeeplearning.com/chap2.html
    def update_weights(self, z, activations,Y):
        delta  = self.loss_prime(activations[-1], Y)*self.activation_prime(z[-1])

        # print(self.loss_prime(activations[-1], Y).shape)
        
        grad_for_b = delta
        grad_for_w = np.dot(delta, activations[-2].transpose())
        # print('b ', grad_for_b)
        # print('w ', grad_for_w)

        self.w[-1] = self.w[-1] - self.alpha*grad_for_w
        self.b[-1] = self.b[-1] - self.alpha*grad_for_b

        d = self.loss_prime(activations[-1], Y)

        for layer in range(2, len(self.num_layers)+1):
            d_activation = self.activation_prime(z[-layer])
            # print('z: ', z[-layer])
            # print(d_activation)
            # print('')
            d = np.dot(self.w[-layer+1].transpose(), d)*d_activation
            #all deltas are equal
            self.b[-layer] = self.b[-layer] - self.alpha*d
            self.w[-layer] = self.w[-layer] - self.alpha*np.dot(d, activations[-layer-1].transpose())
            # print(self.alpha*np.dot(delta, activations[-layer-1].transpose()))

    def train(self):
        self.parse_images()
        for i in range(self.iters):
            print('iter_number: ',i)
            subset = self.image_strs[0:30000]
            random.shuffle(subset)
            for image in subset:
                img_ls = image.split()
                angle = int(img_ls[1])
                # print('angle: ', angle)
                Y = self.logits(angle)

                inputs = [int(i) for i in img_ls[1:193]]
                inputs = np.array(inputs)
                inputs = self.scale(inputs.reshape((192,1)))
                # print(inputs[20])
                z, activations = self.feed_forward(inputs)
                # print(z)
                self.update_weights(z, activations, Y)

    def check_test(self):
        file_test = open(self.data_file, 'r')
        test_strs = file_test.readlines(0)
        self.test_img_strs = test_strs
        count = 0
        file = open('output_comp.txt', 'w')
        
        for image in self.test_img_strs:
            img_ls = image.split()
            angle = int(img_ls[1])
            Y = self.logits(angle)
            inputs = [int(i) for i in img_ls[1:193]]
            inputs = np.array(inputs)
            inputs = self.scale(inputs.reshape((192,1)))
            z, activations = self.feed_forward(inputs)
            pred_angles = [0,90,180,270]
                # print('----------------')
                # print(angle)
                
            # print(pred_angles[np.argmax(activations[-1])], activations[-1])
            # print(pred_angles[np.argmax(activations[-1])], img_ls[1])
            # print('')
            file.write(img_ls[0] + ' ' + str(pred_angles[np.argmax(activations[-1])]) + '\n')
            if pred_angles[np.argmax(activations[-1])] == angle:
                count = count + 1
        file.close()
        print('test images, accuracy: ', (count/943)*100)

    def check(self):
        count = 0
        for image in self.image_strs[20001:20050]:
                img_ls = image.split()
                angle = int(img_ls[1])
                Y = self.logits(angle)
                inputs = [int(i) for i in img_ls[1:193]]
                inputs = np.array(inputs)
                inputs = self.scale(inputs.reshape((192,1)))
                z, activations = self.feed_forward(inputs)
                pred_angles = [0,90,180,270]
                # print('----------------')
                # print(angle)
                
                # print(pred_angles[np.argmax(activations[-1])], activations[-1])
                print(pred_angles[np.argmax(activations[-1])], ' ', z[-1], ' ', activations[-1])
                print('')
                if pred_angles[np.argmax(activations[-1])] == angle:
                    count = count + 1
        print('50 images, count: ', count)

    def save_params(self, save_file):
        ws = np.array([])
        bs = np.array([])
        for layer in range(len(self.num_layers)):
            ws = np.append(ws, np.hstack(self.w[layer]))
            bs = np.append(bs, np.hstack(self.b[layer]))
            f = np.append(ws, bs)
        np.savetxt(save_file, f)

    def extract_params(self, save_file):
        loaded_array = np.loadtxt(save_file)
        ws = []
        bs = []
        init = 0
        final = 0
        prev_num_layer = 192
        for layer in range(len(self.num_layers)):
            final = final + prev_num_layer*self.num_layers[layer]
            ws.append(loaded_array[init:final].reshape(self.num_layers[layer], prev_num_layer))

            init = final
            prev_num_layer = self.num_layers[layer]
        self.w = ws

        for layer in range(len(self.num_layers)):
            final = final + self.num_layers[layer]
            bs.append(loaded_array[init:final].reshape(self.num_layers[layer], 1))
            init = final
        self.b = bs
