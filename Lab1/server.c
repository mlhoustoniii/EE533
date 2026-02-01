/* A simple server in the internet domain using TCP
   The port number is passed as an argument */
#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdlib.h>     // exit(), atoi()
#include <strings.h>    // bzero()
#include <unistd.h>     // read(), write(), close(), fork()
#include <sys/types.h>  // pid_t

void error(char *msg)
{
    perror(msg);
    exit(1);
}

int dostuff(int newsockfd, int cli_pid);        // function prototype

int main(int argc, char *argv[])
{
    int sockfd, newsockfd, portno, clilen;     // sockfd for storing values from socket call, and newsockfd to accept the system call
    struct sockaddr_in serv_addr, cli_addr;    // for server address and client address
    int pid, cli_pid;
    if (argc < 2) {
        fprintf(stderr,"ERROR, no port provided\n");
        exit(1);
    }
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0)
        error("ERROR opening socket");
    bzero((char *) &serv_addr, sizeof(serv_addr));
    portno = atoi(argv[1]);
    serv_addr.sin_family = AF_INET;            // For internet domain (sin = socket internet)
    serv_addr.sin_addr.s_addr = INADDR_ANY;    // gets IP address of machine where the server is running
    serv_addr.sin_port = htons(portno);        // converts from host byter ordering to network byte ordering
    if (bind(sockfd, (struct sockaddr *) &serv_addr,   // binds socket to an address
             sizeof(serv_addr)) < 0)
        error("ERROR on binding");        // an example of failure could be from the socket already being in use
    listen(sockfd,5);                          // listen on the socket for connections; 5 is maximum backlog queue of waiting connections
    clilen = sizeof(cli_addr);
    
    signal(SIGCHLD,SIG_IGN);                // prevents child processes from becoming zombies
    while (1)                                   // continuously accepts new connections as they come in
    {
        newsockfd = accept(sockfd,(struct sockaddr *) &cli_addr, &clilen);  // open streaming socket
        if (newsockfd < 0)
            error("ERROR on accept");
        pid = fork();                               // fork (create) child process from parent
        if (pid < 0)
            error("ERROR on fork");
        if (pid == 0)                               // instructions for child to exectute
        {
            close(sockfd);                          // child closes sockfd (listening socket), as it is unnecessary 
            cli_pid = getpid();
            dostuff(newsockfd, cli_pid);            // child calls dostuff (which will handle the communication)
            exit(0);                                // exits upon disconnection of client
        }
        else                                        // code for parent to execute, after calling child
            close(newsockfd);                       // parent closes newsockfd, as it does not talk to the client; goes back to accept to wait for new client (listening socket continues)
    } /* end of while */
    close(sockfd);
    return 0;
} /*end of main*/
    
int dostuff(int newsockfd, int cli_pid)                     // function description
{
    char buffer[256];
    int n;
    while(1)                                                // existing connection remains established and reads latest message from client
    {
        bzero(buffer,256);
        n = read(newsockfd,buffer,255);                    // reads string into buffer from the socket
        if (n < 0) error("ERROR reading from socket");
        printf("Here is the message: %s\nFrom: %d\n",buffer, cli_pid);        // displays received data and passes in the child's process ID
        n = write(newsockfd,"I got your message",18);      // sends auto response to client, if transmission was a success
        if (n < 0) error("ERROR writing to socket");
    }
    return 0;
}

