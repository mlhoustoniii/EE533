#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h> 
#include <stdlib.h>     // exit(), atoi()
#include <strings.h>    // bzero()
#include <unistd.h>     // read(), write(), close(), fork()
#include <sys/types.h>  // pid_t

void error(char *msg)
{
    perror(msg);
    exit(0);
}

int main(int argc, char *argv[])
{
    int sockfd, portno, n;              // file descriptors; sockfd stores value returned by socket system call

    struct sockaddr_in serv_addr;       // struct for grouping variables; sockaddr_in contains an internet address
    struct hostent *server;             // server is a pointer within hostent

    char buffer[256];
    if (argc < 3) {
       fprintf(stderr,"usage %s hostname port\n", argv[0]);
       exit(0);
    }
    portno = atoi(argv[2]);             // converts our input string and stores port number
    sockfd = socket(AF_INET, SOCK_STREAM, 0);   //returns -1 if unsuccessful, otherwise it is the reference to the socket. '0' means to choose TCP protocol
    if (sockfd < 0)
        error("ERROR opening socket");
    server = gethostbyname(argv[1]);    // returns NULL if unsuccessful
    if (server == NULL) {
        fprintf(stderr,"ERROR, no such host\n");
        exit(0);
    }
    bzero((char *) &serv_addr, sizeof(serv_addr)); // initializes serv_addr to all zeros
    serv_addr.sin_family = AF_INET;                // assigns the code (AF_INET) to the socket internet family (sin_family)
    bcopy((char *)server->h_addr,                   // copies the server’s IP address from the hostent structure into the sockaddr_in structure.
         (char *)&serv_addr.sin_addr.s_addr,
         server->h_length);
    serv_addr.sin_port = htons(portno);             // converts from host byte order to network byte order (big Endian) then assigns to the sin_port
    if (connect(sockfd,(struct sockaddr *)&serv_addr,sizeof(serv_addr)) < 0) // establishes the connection through 'connect'; arguments are socket file descriptor, address of host, and size of the server address
        error("ERROR connecting");
    while(1)                                            // takes users input and transmits, reading response from server
    {
        printf("Please enter the message: ");
        bzero(buffer,256);                              // clear buffer
        fgets(buffer,255,stdin);                        // place input from user into buffer
        n = write(sockfd,buffer,strlen(buffer));        // write buffer's contents into sockfd (file descriptor) for transmission
        if (n < 0)
            error("ERROR writing to socket");
        bzero(buffer,256);                              // clear buffer
        n = read(sockfd,buffer,255);                    // place contents from sockfd into buffer (acknowlegement from server)
        if (n < 0)
            error("ERROR reading from socket");
        printf("%s\n",buffer);                          // prints output to user
    }
    return 0;
}
